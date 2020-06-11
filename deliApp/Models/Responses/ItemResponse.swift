//
//  ItemResponse.swift
//  deliApp
//
//  Created by iJPe on 11/04/20.
//  Copyright © 2020 reliae. All rights reserved.
//

class ItemResponse: Codable {
    let success: Int?
    let message: String?
    let item: ProductItem?
    let product: Product?

    init(success: Int?, message: String?, item: ProductItem?, product: Product?) {
        self.success = success
        self.message = message
        self.item = item
        self.product = product
    }
}
