//
//  CartResponse.swift
//  deliApp
//
//  Created by iJPe on 6/25/19.
//  Copyright © 2019 reliae. All rights reserved.
//

import Foundation

// MARK: - CartResponse
class CartResponse: Codable {
    var success: Int?
    var cart: Cart?
    var message: String?
    
    init(success: Int?, cart: Cart?, message: String?) {
        self.success = success
        self.cart = cart
        self.message = message
    }
}
