//
//  FBUser.swift
//  deliApp
//
//  Created by iJPe on 29/10/19.
//  Copyright © 2019 reliae. All rights reserved.
//

import Foundation

class FBUser: Codable {
    var id: String?
    var email: String?
    var name: String?
    var first_name: String?
    var last_name: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case email = "email"
        case name = "name"
        case first_name = "first_name"
        case last_name = "last_name"
    }
    
    init() {
    }
    
    init(id: String?, email: String?, name: String?, first_name: String?, last_name: String?) {
        self.id = id
        self.email = email
        self.name = name
        self.first_name = first_name
        self.last_name = last_name
    }
}
