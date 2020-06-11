//
//  OrderDetail.swift
//  deliApp
//
//  Created by iJPe on 6/27/19.
//  Copyright © 2019 reliae. All rights reserved.
//

import Foundation

// MARK: - OrderDetail
class OrderDetail: Codable {
    var productId: String?
    var totalItemPrice: Double? = 0
    var items: [Item]? = []
    var uniqueId: Int?
    var productName: String?
    
    enum CodingKeys: String, CodingKey {
        case productId = "product_id"
        case totalItemPrice = "total_item_price"
        case items
        case uniqueId = "unique_id"
        case productName = "product_name"
    }
    
    init() {
    }
    
    init(productId: String?, totalItemPrice: Double?, items: [Item]?, uniqueId: Int?, productName: String?) {
        self.productId = productId
        self.totalItemPrice = totalItemPrice
        self.items = items
        self.uniqueId = uniqueId
        self.productName = productName
    }
}
