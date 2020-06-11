//
//  Phone.swift
//  deliApp
//
//  Created by iJPe on 29/10/19.
//  Copyright © 2019 reliae. All rights reserved.
//

import Foundation

class Phone: Codable {
    var country_code: String?
    var phone: String?
    
    enum CodingKeys: String, CodingKey {
        case country_code = "country_code"
        case phone = "phone"
    }
    
    init() {
    }
    
    init(country_code: String?, phone: String?) {
        self.country_code = country_code
        self.phone = phone
    }
}
