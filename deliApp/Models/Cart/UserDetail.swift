//
//  UserDetails.swift
//  deliApp
//
//  Created by iJPe on 6/27/19.
//  Copyright © 2019 reliae. All rights reserved.
//

import Foundation

// MARK: - UserDetails
class UserDetail: Codable {
    var email, phone, name: String?
    var countryPhoneCode: String? = "+52"
    
    enum CodingKeys: String, CodingKey {
        case email, phone, name
        case countryPhoneCode = "country_phone_code"
    }
    
    init() {
    }
    
    init(email: String?, phone: String?, name: String?, countryPhoneCode: String?) {
        self.email = email
        self.phone = phone
        self.name = name
        self.countryPhoneCode = countryPhoneCode
    }
}
