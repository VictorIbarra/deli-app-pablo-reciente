//
//  DeliveriesResponse.swift
//  deliApp
//
//  Created by iJPe on 26/03/20.
//  Copyright © 2020 reliae. All rights reserved.
//

class DeliveriesResponse: Codable {
    let success: Int?
    let deliveries: [Delivery]?
    let message: String?
    
    init(success: Int?, deliveries: [Delivery]?, message: String?) {
        self.success = success
        self.deliveries = deliveries
        self.message = message
    }
}
