//
//  CardAPI.swift
//  deliApp
//
//  Created by iJPe on 6/3/19.
//  Copyright © 2019 reliae. All rights reserved.
//

import Foundation
import Alamofire

class CardAPI {
    typealias SuccessHandler = (SuccessResponse?, Error?) -> Void
    typealias CardsHandler = (CardsResponse?, Error?) -> Void
    
    func loadCards(for userId: String, completion: @escaping CardsHandler) {
        var _parameters = [String : Any]()
        _parameters["verification_token"] = Identity.shared.user!.serverToken!
        
        Alamofire.request("\(Env.Deli.hostApi)users/\(userId)/cards", method: .get, parameters: _parameters).responseCards { (response) in
            if let response = response.result.value {
                completion(response, nil)
            } else {
                completion(nil, response.error)
            }
        }
    }
    
    func addCard(for userId: String, paymentId: String, cardToken: String, opDeviceSessionId: String! = nil, completion: @escaping SuccessHandler) {
        let _headers = [
            "Content-Type": "application/json"
        ]
        var _parameters = [String : String]()
        _parameters["verification_token"] = Identity.shared.user!.serverToken!
        _parameters["payment_id"] = paymentId
        _parameters["card_token"] = cardToken
        
        if let opS = opDeviceSessionId {
            _parameters["device_session_id"] = opS
        }
        
        Alamofire.request("\(Env.Deli.hostApi)users/\(userId)/cards", method: .post, parameters: _parameters, encoding: JSONEncoding.default, headers: _headers).responseSuccess  { response in
            if let response = response.result.value {
                completion(response, nil)
            } else {
                completion(nil, response.error)
            }
        }
    }
    
    func deleteCard(id: String, completion: @escaping SuccessHandler) {
        var _parameters = [String : Any]()
        _parameters["api_key"] = Env.Deli.token
        _parameters["user_id"] = Identity.shared.user!.id!
        _parameters["verification_token"] = Identity.shared.user!.serverToken!
        
        Alamofire.request("\(Env.Deli.hostApi)cards/\(id)", method: .delete, parameters: _parameters, encoding: JSONEncoding.default).responseSuccess { (response) in
            if let response = response.result.value {
                completion(response, nil)
            } else {
                completion(nil, response.error)
            }
        }
    }
}
