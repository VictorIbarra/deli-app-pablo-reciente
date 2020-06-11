//
//  ProductSpecification.swift
//  deliApp
//
//  Created by iJPe on 10/04/20.
//  Copyright © 2020 reliae. All rights reserved.
//

class ProductSpecification: Codable {
    let uniqueId, type: Int?
    let price: Double?
    let name: String?
    let list: [ProductList]?
    let isRequired: Bool?
    let id: String?

    enum CodingKeys: String, CodingKey {
        case uniqueId = "unique_id"
        case type, price, name, list
        case isRequired = "is_required"
        case id = "_id"
    }

    init(uniqueId: Int?, type: Int?, price: Double?, name: String?, list: [ProductList]?, isRequired: Bool?, id: String?) {
        self.uniqueId = uniqueId
        self.type = type
        self.price = price
        self.name = name
        self.list = list
        self.isRequired = isRequired
        self.id = id
    }
}
