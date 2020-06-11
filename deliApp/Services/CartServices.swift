//
//  CartServices.swift
//  deliApp
//
//  Created by iJPe on 10/9/19.
//  Copyright © 2019 reliae. All rights reserved.
//

import Foundation
import MapKit

class CartServices {
    static func clear(successHandler: @escaping ((Cart) -> Void), errorHandler: @escaping ((Error) -> Void)) {
        API.cart.clearCart { (successResponse, error) in
            if let e = error {
                errorHandler(e)
            } else {
                Identity.shared.cart.clear()
                CartServices.load(successHandler: { (cart) in
                    successHandler(cart)
                }) { (error) in
                    errorHandler(error)
                }
            }
        }
    }
    
    static func load(successHandler: @escaping ((Cart) -> Void) = { _ in }, errorHandler: @escaping ((Error) -> Void) = { _ in }) {
        API.cart.loadCartForUser(id: Identity.shared.user!.id!) { (cartResponse, error) in
            if let e = error {
                errorHandler(e)
            } else {
                Identity.shared.cart.data = cartResponse?.cart
                Identity.shared.cart.extra.checkIfAddressIsFavorite()
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "cartUpdated"), object: self, userInfo: nil)
                
                if let store = Identity.shared.cart.data?.store {
                    if Identity.shared.cart.extra.storePaymentMethod.gateways.count <= 0 {
                        StoreServices.paymentMethod(for: store.id!)
                    }
                    
                    let to = CLLocationCoordinate2D(latitude: store.location![0], longitude: store.location![1])
                    CartServices.getDeliveryCost(from: Identity.shared.cart.data!.addressLocation, to: to, costHandler: { (cost) in
                        successHandler(cartResponse!.cart!)
                    }) { (error) in
                        logger.error(error)
                        errorHandler(error)
                    }
                } else {
                    successHandler(cartResponse!.cart!)
                }
            }
        }
    }
    
    static func update(isAddressUpdated: Bool = false, successHandler: @escaping ((Cart) -> Void), errorHandler: @escaping ((Error) -> Void)) {
        Identity.shared.cart.data!.userType = Identity.shared.user?.userType
        Identity.shared.cart.data!.userTypeID = Identity.shared.user?.id
        Identity.shared.cart.data!.userID = Identity.shared.user?.id
        
        API.cart.update(cart: Identity.shared.cart.data!) { (cartResponse, error) in
            if let cart = cartResponse!.cart {
                Identity.shared.cart.data = cart
                Identity.shared.cart.extra.checkIfAddressIsFavorite()
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "cartUpdated"), object: self, userInfo: nil)
                
                if Identity.shared.cart.extra.storePaymentMethod.gateways.count <= 0 {
                    StoreServices.paymentMethod(for: Identity.shared.cart.data.store!.id!)
                }
                
                if isAddressUpdated || Identity.shared.cart.extra.deliveryCost <= 0 {
                    let to = CLLocationCoordinate2D(latitude:  Identity.shared.cart.data!.store!.location![0], longitude: Identity.shared.cart.data!.store!.location![1])
                    CartServices.getDeliveryCost(from: Identity.shared.cart.data!.addressLocation, to: to, costHandler: { (cost) in
                        successHandler(cart)
                    }) { (error) in
                        logger.error(error)
                        errorHandler(error)
                    }
                } else {
                    successHandler(cart)
                }
            } else {
                errorHandler(error!)
            }
        }
    }
    
    static func createOrder(for cartId: String, payWith cardId: String, cvv: String! = nil, opDeviceSessionId: String! = nil, successHandler: @escaping ((String) -> Void), errorMessageHandler: @escaping ((String) -> Void)) {
        API.cart.createOrder(for: cartId, payWith: cardId, cvv: cvv, opDeviceSessionId: opDeviceSessionId, completion: { (response, error) in
            if let e = error {
                errorMessageHandler(e.localizedDescription)
            } else {
                if response?.success == 1 {
                    CartServices.load(successHandler: { (cart) in
                        successHandler(response!.order_id!)
                    }) { (error) in
                        errorMessageHandler(error.localizedDescription)
                    }
                } else {
                    errorMessageHandler(response!.message!)
                }
            }
        })
    }
    
    static func getDeliveryCost(from: CLLocationCoordinate2D, to: CLLocationCoordinate2D, costHandler: @escaping ((Double) -> Void) = { _ in }, errorHandler: @escaping ((Error) -> Void) = { _ in }) {
        API.cart.getDeliveryCost(from: from, to: to) { (deliveryCostResponse, error) in
            if let cost = deliveryCostResponse!.cost {
                Identity.shared.cart.extra.deliveryCost = cost
                costHandler(cost)
            } else {
                errorHandler(error!)
            }
        }
    }
}
