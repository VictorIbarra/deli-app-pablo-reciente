//
//  ProductList.swift
//  deliApp
//
//  Created by iJPe on 10/04/20.
//  Copyright © 2020 reliae. All rights reserved.
//

class ProductList: Codable {
    let uniqueId: Int?
    let price: Double?
    let name: String?
    let isUserSelected, isDefaultSelected: Bool?
    let id: String?
    var isSelected: Bool = false

    enum CodingKeys: String, CodingKey {
        case uniqueId = "unique_id"
        case price, name
        case isUserSelected = "is_user_selected"
        case isDefaultSelected = "is_default_selected"
        case id = "_id"
    }

    init(uniqueId: Int?, price: Double?, name: String?, isUserSelected: Bool?, isDefaultSelected: Bool?, id: String?) {
        self.uniqueId = uniqueId
        self.price = price
        self.name = name
        self.isUserSelected = isUserSelected
        self.isDefaultSelected = isDefaultSelected
        self.id = id
    }
}
