//
//  ProductsResponse.swift
//  deliApp
//
//  Created by iJPe on 10/04/20.
//  Copyright © 2020 reliae. All rights reserved.
//

class ProductsResponse: Codable {
    let success: Int?
    let message: String?
    let products: [Product]?

    init(success: Int?, message: String?, products: [Product]?) {
        self.success = success
        self.message = message
        self.products = products
    }
}
