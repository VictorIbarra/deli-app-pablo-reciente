//
//  PopularResponse.swift
//  MoviesJP
//
//  Created by iJPe on 2/26/19.
//  Copyright © 2019 jp. All rights reserved.
//

import Foundation

class AddressListResponse: Codable {
    var success: Int?
    var message: String?
    var addresses: [Address]?
    
    init(success: Int?, message: String?, addresses: [Address]?) {
        self.success = success
        self.message = message
        self.addresses = addresses
    }
}

class UserID: Codable {
    var oid: String?
    
    enum CodingKeys: String, CodingKey {
        case oid = "$oid"
    }
    
    init(oid: String?) {
        self.oid = oid
    }
}
