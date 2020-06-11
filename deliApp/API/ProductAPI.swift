//
//  ProductAPI.swift
//  deliApp
//
//  Created by iJPe on 11/04/20.
//  Copyright © 2020 reliae. All rights reserved.
//

import Foundation
import Alamofire

class ProductAPI {
    typealias LoadProductsHandler = (ProductsResponse?, Error?) -> Void
    typealias GetItemHandler = (ItemResponse?, Error?) -> Void
    
    func getProducts(for storeId: String, completion: @escaping LoadProductsHandler) {
        let _headers = [
            "Content-Type": "application/json"
        ]
        
        var _parameters = [String : Any]()
        _parameters["user_id"] = Identity.shared.user?.id
        _parameters["verification_token"] = Identity.shared.user!.serverToken!
        
        Alamofire.request("\(Env.Deli.hostApi)stores/\(storeId)/products", method: .get, parameters: _parameters, headers: _headers).responseProducts { (response) in
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
    
    func getItem(for itemId: String, completion: @escaping GetItemHandler) {
        let _headers = [
            "Content-Type": "application/json"
        ]
        
        var _parameters = [String : Any]()
        _parameters["user_id"] = Identity.shared.user?.id
        _parameters["verification_token"] = Identity.shared.user!.serverToken!
        
        Alamofire.request("\(Env.Deli.hostApi)items/\(itemId)", method: .get, parameters: _parameters, headers: _headers).responseItem { (response) in
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
