//
//  PaymentMethodsResponse.swift
//  deliApp
//
//  Created by iJPe on 19/02/20.
//  Copyright © 2020 reliae. All rights reserved.
//

class PaymentMethodResponse: Codable {
    var success: Int?
    var payment_method: PaymentMethod?
    var message: String?
    
    init(success: Int?, payment_method: PaymentMethod?, message: String?) {
        self.success = success
        self.payment_method = payment_method
        self.message = message
    }
}
