//
//  CreateOrderResponse.swift
//  deliApp
//
//  Created by iJPe on 01/05/20.
//  Copyright © 2020 reliae. All rights reserved.
//

class CreateOrderResponse: Codable {
    let success: Int?
    let message: String?
    let order_id: String?

    init(success: Int?, message: String?, order_id: String?) {
        self.success = success
        self.message = message
        self.order_id = order_id
    }
}
