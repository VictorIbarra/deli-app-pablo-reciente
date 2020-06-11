//
//  OrderAPI.swift
//  deliApp
//
//  Created by iJPe on 7/30/19.
//  Copyright © 2019 reliae. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class OrderAPI {
    typealias LoadOrderHandler = (OrderResponse?, Error?) -> Void
    typealias LoadOrdersHandler = (OrdersResponse?, Error?) -> Void
    
    func loadOrders(withStatus statusId: Int, completion: @escaping LoadOrdersHandler) {
        let _headers = [
            "Content-Type": "application/json"
        ]
        
        var _parameters = [String : Any]()
        _parameters["user_id"] = Identity.shared.user?.id
        _parameters["verification_token"] = Identity.shared.user!.serverToken!
        _parameters["status_id"] = statusId
        
        Alamofire.request("\(Env.Deli.hostApi)users/\(Identity.shared.user!.id!)/orders", method: .get, parameters: _parameters, headers: _headers).responseOrders { (response) in
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
    
    func loadOrder(id: String, completion: @escaping LoadOrderHandler) {
        let _headers = [
           "Content-Type": "application/json"
       ]
       
       var _parameters = [String : Any]()
       _parameters["user_id"] = Identity.shared.user?.id
       _parameters["verification_token"] = Identity.shared.user!.serverToken!
       
       Alamofire.request("\(Env.Deli.hostApi)users/\(Identity.shared.user!.id!)/orders/\(id)", method: .get, parameters: _parameters, headers: _headers).responseOrder { (response) in
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
