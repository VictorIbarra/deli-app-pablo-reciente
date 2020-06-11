//
//  StoreServices.swift
//  deliApp
//
//  Created by iJPe on 18/02/20.
//  Copyright © 2020 reliae. All rights reserved.
//

import UIKit
import CoreData
import MapKit

class StoreServices {
    static func around(fromLocation location: CLLocationCoordinate2D, around: Double, successHandler: @escaping (([Delivery]) -> Void) = { _ in }, errorHandler: @escaping ((Error) -> Void)) {
        API.store.around(fromLocation: location, around: around) { (response, error) in
            if let e = error {
                errorHandler(e)
            } else {
                let deliveries = response!.deliveries!
                
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                let context = appDelegate.persistentContainer.viewContext
                let entity = NSEntityDescription.entity(forEntityName: "StoreModel", in: context)

                let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: "StoreModel")
                let request = NSBatchDeleteRequest(fetchRequest: fetch)

                do {
                    try context.execute(request)
                } catch {
                    print("Failed delete")
                }

                var i = 0
                for delivery in deliveries {
                    delivery.stores!.forEach({ (s) in
                        let r = NSManagedObject(entity: entity!, insertInto: context)
                        r.setValue(s.id, forKey: "id")
                        r.setValue(i, forKey: "idInternal")
                        r.setValue(s.name, forKey: "name")
                        r.setValue(s.imageURL, forKey: "image_url")
                        r.setValue(delivery.id, forKey: "delivery_id")
                        r.setValue(s.distance, forKey: "distance")
                        r.setValue(s.isOpenNow, forKey: "is_open_now")

//                        let day = Calendar.current.dateComponents([.weekday], from: SessionSingleton.sharedInstance.server_time).weekday! - 1
//                        s.storeTime?.forEach({ (time) in
//                            if time.day == day {
//                                r.setValue(time.dayTime?[0].storeOpenTime, forKey: "open_time")
//                                r.setValue(time.dayTime?[0].storeCloseTime, forKey: "close_time")
//                            }
//                        })

                        do {
                            try context.save()
                            i = i + 1
                        } catch {
                            print("Failed saving station")
                        }
                    })
                }
                
                successHandler(deliveries)
            }
        }
    }
    
    static func make(storeId: String, favorite: Bool, forUserId userId: String, successHandler: @escaping ((SuccessResponse) -> Void), errorHandler: @escaping ((String) -> Void)) {
        API.store.make(storeId: storeId, favorite: favorite, forUserId: userId) { (response, error) in
            if response?.success == 1 {
                StoreServices.getFavoriteStores(successHandler: { (_) in
                    successHandler(response!)
                }) { (error) in
                    errorHandler(error.localizedDescription)
                }
            } else {
                errorHandler(error.debugDescription)
            }
        }
    }
    
    static func getFavoriteStores(successHandler: @escaping (([Store]) -> Void) = { _ in }, errorHandler: @escaping ((Error) -> Void) = { _ in }) {
        API.store.getFavoriteStores(for: Identity.shared.user!.id!) { (response, error) in
            if let stores = response?.stores {
                Identity.shared.user!.favoriteStores = stores
                successHandler(stores)
            } else {
                logger.error("Not load favorite stores: \(error.debugDescription)")
                errorHandler(error!)
            }
        }
    }
    
    static func getStore(withId id: String, successHandler: @escaping ((Store) -> Void), errorHandler: @escaping ((Error) -> Void)) {
        API.store.getStore(withId: id) { (response, error) in
            if let e = error {
                errorHandler(e)
            } else {
                successHandler(response!.store!)
            }
        }
    }
    
    static func paymentMethod(for storeId: String, successHandler: @escaping ((PaymentMethod) -> Void) = { _ in }, errorHandler: @escaping ((Error) -> Void) = { _ in }) {
        API.store.paymentMethod(for: storeId) { (response, error) in
            if let method = response!.payment_method {
                Identity.shared.cart.extra.storePaymentMethod = method
                successHandler(method)
            } else {
                errorHandler(error!)
            }
        }
    }
}
