//
//  UserAPI.swift
//  deliApp
//
//  Created by iJPe on 6/18/19.
//  Copyright © 2019 reliae. All rights reserved.
//

import Foundation
import Alamofire

class UserAPI {
    typealias UserSignUpHandler = (SignUpResponse?, Error?) -> Void
    typealias ConfirmPhoneHandler = (ConfirmPhoneResponse?, CustomError?) -> Void
    typealias UserLoginHandler = (LoginResponse?, Error?) -> Void
    typealias UserInformationHandler = (UserInformationResponse?, Error?) -> Void
    
    func signUp(user: User, completion: @escaping UserSignUpHandler) {
        let _headers = [
            "Content-Type": "application/json"
        ]

        var _parameters = [String : Any]()
        _parameters["email"] = user.email
        _parameters["phone"] = user.phone
        _parameters["password"] = user.password
        _parameters["first_name"] = user.firstName
        _parameters["last_name"] = user.lastName
        _parameters["city"] = user.city
        _parameters["address"] = user.address
        _parameters["device_token"] = user.deviceToken
        _parameters["is_email_verified"] = user.isEmailVerified
        _parameters["referral_code"] = user.referralCode
        _parameters["location"] = user.location
        _parameters["login_by"] = "manual"
        _parameters["is_phone_number_verified"] = true
        _parameters["country_id"] = "5b27da324b51a86523b8877f"
        _parameters["country_phone_code"] = "+52"
        _parameters["device_type"] = "ios"
        _parameters["app_version"] = "\(UIApplication.appVersion())"

        if let ids = user.socialIDS {
            _parameters["social_ids"] = ids
        }
        
        Alamofire.request("\(Env.Deli.hostApi)users", method: .post, parameters: _parameters, encoding: JSONEncoding.default, headers: _headers).responseSignUp  { response in
            if let response = response.result.value {
                completion(response, nil)
            } else {
                completion(nil, response.error)
            }
        }
    }
    
    func codeForPhoneVerification(phone: Phone, completion: @escaping ConfirmPhoneHandler) {
        let _headers = [
            "Content-Type": "application/json"
        ]

        var _parameters = [String : Any]()
        _parameters["country_phone_code"] = phone.country_code
        _parameters["phone"] = phone.phone

        Alamofire.request("\(Env.Deli.hostApi)users/confirm_phone", method: .post, parameters: _parameters, encoding: JSONEncoding.default, headers: _headers).responseConfirmPhone  { response in
            if let response = response.result.value {
                if response.success == 1 {
                    completion(response, nil)
                } else {
                    completion(nil, CustomError.validationError(response.message!))
                }
            } else {
                let e = CustomError.validationError(response.error!.localizedDescription)
                completion(nil, e)
            }
        }
    }
    
    func login(user: String, password: String, socialId: String! = nil, completion: @escaping UserLoginHandler) {
        let _headers = [
            "Content-Type": "application/json"
        ]
        
        var _parameters = [String : String]()
        _parameters["email"] = user
        _parameters["phone"] = user
        _parameters["password"] = password
//                _parameters["login_by"] = "manual"
        if let s = socialId {
            _parameters["social_id"] = s
        }
        
        Alamofire.request("\(Env.Deli.hostApi)users/login", method: .post, parameters: _parameters, encoding: JSONEncoding.default, headers: _headers).responseLogin { (response) in
            if let response = response.result.value {
                if response.success == 1 {
                    completion(response, nil)
                } else {
                    completion(nil, CustomError.validationError(response.message!))
                }
            } else {
                completion(nil, response.error)
            }
        }
    }
    
    func loadInformationFor(userId: String, completion: @escaping UserInformationHandler) {
        let _headers = [
            "Content-Type": "application/json"
        ]
        
        var _parameters = [String : String]()
        _parameters["user_id"] = userId
        _parameters["verification_token"] = Identity.shared.user!.serverToken!
        
        Alamofire.request("\(Env.Deli.hostApi)users/\(userId)", method: .get, parameters: _parameters, headers: _headers).responseUserInformation { (response) in
            if let response = response.result.value {
                if response.success == 1 {
                    completion(response, nil)
                } else {
                    completion(nil, CustomError.validationError(response.message!))
                }
            } else {
                completion(nil, response.error)
            }
        }
    }
}
