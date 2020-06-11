//
//  StoreAPI.swift
//  deliApp
//
//  Created by iJPe on 8/17/19.
//  Copyright © 2019 reliae. All rights reserved.
//

import Foundation
import Alamofire
import MapKit

class StoreAPI {
    typealias LoadStoresAroundHandler = (DeliveriesResponse?, Error?) -> Void
    typealias StoresHandler = (StoresResponse?, Error?) -> Void
    typealias GetStoreHandler = (StoreResponse?, Error?) -> Void
    typealias GetPaymentMethodsHandler = (PaymentMethodResponse?, Error?) -> Void
    typealias SuccessHandler = (SuccessResponse?, Error?) -> Void
    
    func around(fromLocation location: CLLocationCoordinate2D, around: Double, completion: @escaping LoadStoresAroundHandler) {
        let _headers = [
            "Content-Type": "application/json"
        ]
        
        var _parameters = [String : Any]()
        _parameters["user_id"] = Identity.shared.user?.id
        _parameters["verification_token"] = Identity.shared.user!.serverToken!
        _parameters["latitude"] = location.latitude
        _parameters["longitude"] = location.longitude
        _parameters["radius"] = around
        
        Alamofire.request("\(Env.Deli.hostApi)stores/around", method: .get, parameters: _parameters, headers: _headers).responseStoresAround { (response) in
            if let response = response.result.value {
                if response.success == 0 {
                    completion(nil, ApiError.message(response.message!))
                }
                
                completion(response, nil)
            } else {
                completion(nil, response.error)
            }
        }
    }
    
    func getFavoriteStores(for userId: String, completion: @escaping StoresHandler) {
        let _headers = [
            "Content-Type": "application/json",
            "Authorization": "bearer \(Identity.shared.user!.serverToken!)"
        ]
        
        Alamofire.request("\(Env.Deli.hostApi)users/\(userId)/favorite_stores", method: .get, headers: _headers).responseStores { (response) in
            if let response = response.result.value {
                if response.success == 0 {
                    completion(nil, ApiError.message(response.message!))
                }
                
                completion(response, nil)
            } else {
                completion(nil, response.error)
            }
        }
    }
    
    func make(storeId: String, favorite: Bool, forUserId userId: String, completion: @escaping SuccessHandler) {
        let _headers = [
            "Content-Type": "application/json",
            "Authorization": "bearer \(Identity.shared.user!.serverToken!)"
        ]
        
        var _parameters = [String : Any]()
        _parameters["user_id"] = userId
        
        var httpMethod: HTTPMethod = .post
        if !favorite {
            httpMethod = .delete
        }
        
        Alamofire.request("\(Env.Deli.hostApi)stores/\(storeId)/favorite", method: httpMethod, parameters: _parameters, encoding: JSONEncoding.default, headers: _headers).responseSuccess { (response) in
            if let response = response.result.value {
                if response.success == 0 {
                    completion(nil, ApiError.message(response.message!))
                }
                
                completion(response, nil)
            } else {
                completion(nil, response.error)
            }
        }
    }
    
    func getStore(withId id: String, completion: @escaping GetStoreHandler) {
        let _headers = [
            "Content-Type": "application/json"
        ]
        
        var _parameters = [String : Any]()
        _parameters["user_id"] = Identity.shared.user?.id
        _parameters["verification_token"] = Identity.shared.user!.serverToken!
        
        Alamofire.request("\(Env.Deli.hostApi)stores/\(id)", method: .get, parameters: _parameters, headers: _headers).responseStore { (response) in
            if let response = response.result.value {
                if response.success == 0 {
                    completion(nil, ApiError.message(response.message!))
                }
                
                completion(response, nil)
            } else {
                completion(nil, response.error)
            }
        }
    }
    
    func paymentMethod(for storeId: String, completion: @escaping GetPaymentMethodsHandler) {
        let _headers = [
            "Content-Type": "application/json"
        ]
        
        var _parameters = [String : Any]()
        _parameters["user_id"] = Identity.shared.user?.id
        _parameters["verification_token"] = Identity.shared.user!.serverToken!
        
        Alamofire.request("\(Env.Deli.hostApi)stores/\(storeId)/payment_method", method: .get, parameters: _parameters, headers: _headers).responsePaymentMethod { (response) in
            if let response = response.result.value {
                if response.success == 0 {
                    completion(nil, ApiError.message(response.message!))
                }
                
                completion(response, nil)
            } else {
                completion(nil, response.error)
            }
        }
    }
}
