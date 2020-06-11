//
//  PaymentGateway.swift
//  deliApp
//
//  Created by iJPe on 18/02/20.
//  Copyright © 2020 reliae. All rights reserved.
//

class PaymentGateway: Codable {
    var id: String?
    var name: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
    }
    
    init(id: String?, name: String?) {
        self.id = id
        self.name = name
    }
}
