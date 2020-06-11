//
//  UserInformationResponse.swift
//  deliApp
//
//  Created by iJPe on 6/21/19.
//  Copyright © 2019 reliae. All rights reserved.
//

import Foundation

class UserInformationResponse: Codable {
    var success: Int?
    var user: UserResponse?
    var message: String?
    
    init(success: Int?, user: UserResponse?, message: String?) {
        self.success = success
        self.user = user
        self.message = message
    }
}
