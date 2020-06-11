//
//  UserLogin.swift
//  deliApp
//
//  Created by iJPe on 6/18/19.
//  Copyright © 2019 reliae. All rights reserved.
//

import Foundation

// MARK: - LoginResponse
class LoginResponse: Codable {
    var success: Int?
    var user: UserResponse?
    var message: String?
    
    init(success: Int?, user: UserResponse?, message: String?) {
        self.success = success
        self.user = user
        self.message = message
    }
}
