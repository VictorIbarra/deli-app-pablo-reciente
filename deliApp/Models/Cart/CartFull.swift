//
//  CartFull.swift
//  deliApp
//
//  Created by iJPe on 10/04/20.
//  Copyright © 2020 reliae. All rights reserved.
//

class CartFull {
    var data: Cart! = nil
    var extra: CartExtra = CartExtra()
    
    func clear() {
        data.orderDetails = []
        extra.storePaymentMethod.gateways = []
    }
}
