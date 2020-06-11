//
//  Identity.swift
//  deliApp
//
//  Created by iJPe on 6/21/19.
//  Copyright © 2019 reliae. All rights reserved.
//

import Foundation
import FBSDKLoginKit
import SwiftKeychainWrapper

class Identity {
    static var shared: Identity = { return Identity() }()
    var user: User?
    var cart: CartFull = CartFull()
    var cartExtra: CartExtra = CartExtra()
    
    //MARK: Functions
    static func signUp(user: User, userHandler: @escaping ((User) -> Void), errorHandler: @escaping ((Error) -> Void)) {
        logger.info("SIGNUP")
        UserServices.signUp(user: user, successHandler: { (u) in
            self.login(user: user.phone!, password: user.password!, userHandler: { (_u) in
                userHandler(_u)
            }) { (error) in
                errorHandler(error)
            }
        }) { (error) in
            errorHandler(error)
        }
    }
    
    static func login(user: String, password: String, socialId: String! = nil, userHandler: @escaping ((User) -> Void), errorHandler: @escaping ((Error) -> Void)) {
        logger.info("LOGIN")
        UserServices.login(user: user, password: password, socialId: socialId, successHandler: { (user) in
            Identity.shared.user = user
            KeychainWrapper.standard.set(user.serverToken!, forKey: "token")
            
            UserServices.loadInformationFor(userId: user.id!, successHandler: { (u) in
                KeychainWrapper.standard.set(u.email!, forKey: "email")
                KeychainWrapper.standard.set(u.phone!, forKey: "phone")
                KeychainWrapper.standard.set(password, forKey: "password")
                KeychainWrapper.standard.set(u.id!, forKey: "id")
                KeychainWrapper.standard.set(u.cartID!, forKey: "cart_id")
                if u.socialIDS?.count ?? 0 > 0, let sId = u.socialIDS?[0] {
                    KeychainWrapper.standard.set(sId, forKey: "socialId")
                }
                Identity.shared.user = u
                userHandler(user)
            }) { (error) in
                errorHandler(error)
            }
        }) { (error) in
            errorHandler(error)
        }
    }
    
    static func logout() {
        Identity.shared.user = nil
        KeychainWrapper.standard.removeObject(forKey: "id")
        KeychainWrapper.standard.removeObject(forKey: "email")
        KeychainWrapper.standard.removeObject(forKey: "phone")
        KeychainWrapper.standard.removeObject(forKey: "socialId")
        KeychainWrapper.standard.removeObject(forKey: "password")
        let fbManager: LoginManager = LoginManager()
        fbManager.logOut()
        logger.info("LOGOUT")
    }
}
