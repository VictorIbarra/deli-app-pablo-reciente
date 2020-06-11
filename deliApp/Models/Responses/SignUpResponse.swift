//
//  SignUpResponse.swift
//  deliApp
//
//  Created by iJPe on 6/23/19.
//  Copyright © 2019 reliae. All rights reserved.
//

import Foundation

// MARK: - SignUpResponse
class SignUpResponse: Codable {
    var success: Int?
    var user: UserResponse?
    var message: String?
    
    init(success: Int?, user: UserResponse?, message: String?) {
        self.success = success
        self.user = user
        self.message = message
    }
}
