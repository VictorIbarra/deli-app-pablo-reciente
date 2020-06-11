//
//  OrderServices.swift
//  deliApp
//
//  Created by iJPe on 16/10/19.
//  Copyright © 2019 reliae. All rights reserved.
//

import Foundation

class OrderServices {
    static func loadOrder(id: String, successHandler: @escaping ((Order) -> Void), errorHandler: @escaping ((Error) -> Void)) {
        API.order.loadOrder(id: id) { (orderResponse, error) in
            if let e = error {
                errorHandler(e)
            } else {
                successHandler(orderResponse!.order!)
            }
        }
    }
    
    static func loadActiveOrders(successHandler: @escaping (([Order]) -> Void), errorHandler: @escaping ((Error) -> Void)) {
        API.order.loadOrders(withStatus: 1) { (ordersResponse, error) in
            if let e = error {
                errorHandler(e)
            } else {
                successHandler(ordersResponse!.orders!)
            }
        }
    }
    
    static func loadHistoricalOrders(successHandler: @escaping (([Order]) -> Void), errorHandler: @escaping ((Error) -> Void)) {
        API.order.loadOrders(withStatus: 10) { (ordersResponse, error) in
            if let e = error {
                errorHandler(e)
            } else {
                successHandler(ordersResponse!.orders!)
            }
        }
    }
}
