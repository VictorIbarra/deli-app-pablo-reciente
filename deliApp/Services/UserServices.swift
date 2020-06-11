//
//  UserServices.swift
//  deliApp
//
//  Created by iJPe on 29/10/19.
//  Copyright © 2019 reliae. All rights reserved.
//

import Foundation

class UserServices {
    static func signUp(user: User, successHandler: @escaping ((User) -> Void), errorHandler: @escaping ((Error) -> Void)) {
        API.user.signUp(user: user) { (response, error) in
            if let e = error {
                errorHandler(e)
            } else {
                successHandler(response!.user!)
            }
        }
    }
    
    static func codeForPhoneVerification(phone: Phone, successHandler: @escaping ((String) -> Void), errorHandler: @escaping ((CustomError) -> Void)) {
        API.user.codeForPhoneVerification(phone: phone) { (response, error) in
            if let e = error {
                errorHandler(e)
            } else {
                successHandler(response!.code!)
            }
        }
    }
    
    static func login(user: String, password: String, socialId: String! = nil, successHandler: @escaping ((User) -> Void), errorHandler: @escaping ((Error) -> Void)) {
        API.user.login(user: user, password: password, socialId: socialId) { (response, error) in
            if let e = error {
                errorHandler(e)
            } else {
                successHandler(response!.user!)
            }
        }
    }
    
    static func loadInformationFor(userId: String, successHandler: @escaping ((User) -> Void), errorHandler: @escaping ((Error) -> Void)) {
        API.user.loadInformationFor(userId: userId) { (response, error) in
            if let e = error {
                errorHandler(e)
            } else {
                successHandler(response!.user!)
            }
        }
    
    }
}
