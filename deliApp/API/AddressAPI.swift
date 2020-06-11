//
//  MoviesAPI.swift
//  MoviesJP
//
//  Created by iJPe on 2/26/19.
//  Copyright © 2019 jp. All rights reserved.
//

import Alamofire

class AddressAPI {
    typealias AddressListHandler = (AddressListResponse?, Error?) -> Void
    typealias SuccessHandler = (SuccessResponse?, Error?) -> Void
    
    func loadAddresses(completion: @escaping AddressListHandler) {
        var _parameters = [String : Any]()
        _parameters["api_key"] = Env.Deli.token
        _parameters["verification_token"] = Identity.shared.user?.serverToken
        
        Alamofire.request("\(Env.Deli.hostApi)users/\(Identity.shared.user!.id!)/addresses", method: .get, parameters: _parameters).responseAddressList { (response) in
            if let response = response.result.value {
                completion(response, nil)
            } else {
                completion(nil, response.error)
            }
        }
    }
    
    func save(address: NewAddress, forUserId userId: String, completion: @escaping SuccessHandler) {
        let _headers = [
            "Content-Type": "application/json",
            "Authorization": "bearer \(Identity.shared.user!.serverToken!)"
        ]
        
        var _parameters = [String : Any]()
        _parameters["user_id"] = userId
        _parameters["label"] = address.label
        _parameters["address"] = address.address
        _parameters["apt_no"] = address.apt_no
        _parameters["description"] = address.description
        _parameters["location"] = address.location
        
        Alamofire.request("\(Env.Deli.hostApi)users/\(Identity.shared.user!.id!)/addresses", method: .post, parameters: _parameters, encoding: JSONEncoding.default, headers: _headers).responseSuccess { (response) in
            if let response = response.result.value {
                completion(response, nil)
            } else {
                completion(nil, response.error)
            }
        }
    }
    
    func deleteAddress(id: String, completion: @escaping SuccessHandler) {
        var _parameters = [String : Any]()
        _parameters["api_key"] = Env.Deli.token
        _parameters["user_id"] = Identity.shared.user?.id!
        _parameters["verification_token"] = Identity.shared.user?.serverToken
        
        Alamofire.request("\(Env.Deli.hostApi)addresses/\(id)", method: .delete, parameters: _parameters, encoding: JSONEncoding.default).responseSuccess { (response) in
            if let response = response.result.value {
                completion(response, nil)
            } else {
                completion(nil, response.error)
            }
        }
    }
}
