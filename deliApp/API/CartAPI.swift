//
//  CartAPI.swift
//  deliApp
//
//  Created by iJPe on 6/26/19.
//  Copyright © 2019 reliae. All rights reserved.
//

import Foundation
import Alamofire
import MapKit

class CartAPI {
    typealias LoadCartHandler = (CartResponse?, Error?) -> Void
    typealias SuccessHandler = (SuccessResponse?, Error?) -> Void
    typealias DeliveryCostHandler = (DeliveryCostResponse?, Error?) -> Void
    typealias CreateOrderHandler = (CreateOrderResponse?, Error?) -> Void
    
    func loadCartForUser(id: String, completion: @escaping LoadCartHandler) {
        let _headers = [
            "Content-Type": "application/json"
        ]
        
        var _parameters = [String : Any]()
        _parameters["user_id"] = id
        _parameters["verification_token"] = Identity.shared.user!.serverToken!
        
        Alamofire.request("\(Env.Deli.hostApi)users/\(id)/carts/active", method: .get, parameters: _parameters, headers: _headers).responseCart  { response in
            if let e = response.error {
                completion(nil, e)
            } else {
                completion(response.result.value, nil)
            }
        }
    }
    
    func update(cart: Cart, completion: @escaping LoadCartHandler) {
        let _headers = [
            "Content-Type": "application/json"
        ]
        
        var _parameters = [String : Any]()
        _parameters = (cart.build().getJson())!
        _parameters["store_id"] = cart.storeId
        _parameters["user_id"] = Identity.shared.user!.id!
        _parameters["verification_token"] = Identity.shared.user!.serverToken!
        
        Alamofire.request("\(Env.Deli.hostApi)carts/\(Identity.shared.cart.data.id!)", method: .put, parameters: _parameters, encoding: JSONEncoding.default, headers: _headers).responseCart { (response) in
            if let response = response.result.value {
                completion(response, nil)
            } else {
                logger.error(response.error as Any)
                completion(nil, response.error)
            }
        }
    }
    
    func clearCart(completion: @escaping SuccessHandler) {
        let _headers = [
            "Content-Type": "application/json"
        ]
        
        var _parameters = [String : Any]()
        _parameters["user_id"] = Identity.shared.user?.id
        _parameters["verification_token"] = Identity.shared.user!.serverToken!
        
        Alamofire.request("\(Env.Deli.hostApi)carts/\(Identity.shared.cart.data!.id!)/clear", method: .post, parameters: _parameters, encoding: JSONEncoding.default, headers: _headers).responseSuccess { (response) in
            if let response = response.result.value {
                completion(response, nil)
            } else {
                completion(nil, response.error)
            }
        }
    }
    
    func createOrder(for cartId: String, payWith cardId: String, cvv: String! = nil, opDeviceSessionId: String! = nil, completion: @escaping CreateOrderHandler) {
        let _headers = [
            "Content-Type": "application/json"
        ]
        
        var _parameters = [String : Any]()
        _parameters["verification_token"] = Identity.shared.user!.serverToken!
        _parameters["user_id"] = Identity.shared.user!.id!
        _parameters["cart_id"] = cartId
        _parameters["card_id"] = cardId
        if let c = cvv {
            _parameters["cvv"] = c
        }
        if let s = opDeviceSessionId {
            _parameters["device_session_id"] = s
        }
        
        Alamofire.request("\(Env.Deli.hostApi)order_payments", method: .post, parameters: _parameters, encoding: JSONEncoding.default, headers: _headers).responseCreateOrder  { (response) in
            if let response = response.result.value {
                completion(response, nil)
            } else {
                completion(nil, response.error)
            }
        }
    }
    
    func getDeliveryCost(from: CLLocationCoordinate2D, to: CLLocationCoordinate2D, completion: @escaping DeliveryCostHandler) {
        var _parameters = [String : Any]()
        _parameters["verification_token"] = Identity.shared.user!.serverToken!
        _parameters["from"] = [from.latitude, from.longitude]
        _parameters["to"] = [to.latitude, to.longitude]
        
        Alamofire.request("\(Env.Deli.hostApi)carts/\(Identity.shared.cart.data!.id!)/delivery_cost", method: .get, parameters: _parameters).responseDeliveryCost { (response) in
            if let response = response.result.value {
                completion(response, nil)
            } else {
                completion(nil, response.error)
            }
        }
    }
}
