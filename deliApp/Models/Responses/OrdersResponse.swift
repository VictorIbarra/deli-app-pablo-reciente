//
//  OrderResponse.swift
//  deliApp
//
//  Created by iJPe on 7/30/19.
//  Copyright © 2019 reliae. All rights reserved.
//

import Foundation

// MARK: - OrdersResponse
class OrdersResponse: Codable {
    let success: Int?
    let orders: [Order]?
    let message: String?
    
    init(success: Int?, orders: [Order]?, message: String?) {
        self.success = success
        self.orders = orders
        self.message = message
    }
}
