//
//  AddressServices.swift
//  deliApp
//
//  Created by iJPe on 26/02/20.
//  Copyright © 2020 reliae. All rights reserved.
//

import UIKit
import CoreData

class AddressServices {
    static func loadAddresses(successHandler: @escaping (([Address]) -> Void) = { _ in }, errorHandler: @escaping ((String) -> Void) = { _ in }) {
        API.address.loadAddresses { (addressesResponse, error) in
            if let addressesResponse = addressesResponse {
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                let context = appDelegate.persistentContainer.viewContext
                let entity = NSEntityDescription.entity(forEntityName: "AddressModel", in: context)
                
                let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: "AddressModel")
                let request = NSBatchDeleteRequest(fetchRequest: fetch)
                
                do {
                    try context.execute(request)
                } catch {
                    errorHandler("Failed saving station")
                }
                
                for address in addressesResponse.addresses! {
                    let a = NSManagedObject(entity: entity!, insertInto: context)
                    a.setValue(address.id, forKey: "id")
                    a.setValue(address.uniqueId, forKey: "unique_id")
                    a.setValue(address.createdAt, forKey: "created_at")
                    a.setValue(address.location?[0], forKey: "location_latitude")
                    a.setValue(address.location?[1], forKey: "location_longitude")
                    a.setValue(address.isDefault, forKey: "is_default")
                    a.setValue(address.address, forKey: "address")
                    a.setValue(address.addressDescription, forKey: "desc")
                    a.setValue(address.aptNo, forKey: "apt_no")
                    a.setValue(address.label, forKey: "label")
                    
                    do {
                        try context.save()
                    } catch {
                        errorHandler("Failed saving station")
                    }
                }
                
                successHandler(addressesResponse.addresses!)
            } else {
                logger.error("Error loading addresses")
                errorHandler(error!.localizedDescription)
            }
        }
    }
    
    static func save(address: NewAddress, forUserId userId: String, successHandler: @escaping ((SuccessResponse) -> Void), errorHandler: @escaping ((String) -> Void)) {
        API.address.save(address: address, forUserId: userId) { (success, error) in
            if success?.success == 1 {
                AddressServices.loadAddresses(successHandler: { (addresses) in
                    successHandler(success!)
                }) { (error) in
                    errorHandler(error)
                }
            } else {
                errorHandler(error!.localizedDescription)
            }
        }
    }
    
    static func deleteAddress(id: String, successHandler: @escaping ((SuccessResponse) -> Void), errorHandler: @escaping ((String) -> Void)) {
        API.address.deleteAddress(id: id) { (success, error) in
            if success?.success == 1 {
                AddressServices.loadAddresses(successHandler: { (addresses) in
                    successHandler(success!)
                }) { (error) in
                    errorHandler(error)
                }
            } else {
                errorHandler(error!.localizedDescription)
            }
        }
    }
}
