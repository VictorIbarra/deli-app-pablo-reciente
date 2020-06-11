//
//  OrderResponse.swift
//  deliApp
//
//  Created by iJPe on 16/10/19.
//  Copyright © 2019 reliae. All rights reserved.
//

import Foundation

// MARK: - OrderResponse
class OrderResponse: Codable {
    let success: Int?
    let order: Order?
    let message: String?
    
    init(success: Int?, order: Order?, message: String?) {
        self.success = success
        self.order = order
        self.message = message
    }
}
