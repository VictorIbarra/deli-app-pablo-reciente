//
//  PaymentMethod.swift
//  deliApp
//
//  Created by iJPe on 19/02/20.
//  Copyright © 2020 reliae. All rights reserved.
//

class PaymentMethod: Codable {
    var gateways: [PaymentGateway] = []
    var cash: Bool = false
    
    private enum CodingKeys: String, CodingKey {
        case gateways
        case cash
    }
    
    init() {
    }
    
    init(gateways: [PaymentGateway], cash: Bool) {
        self.gateways = gateways
        self.cash = cash
    }
}
