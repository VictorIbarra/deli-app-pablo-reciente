//
//  Product.swift
//  deliApp
//
//  Created by iJPe on 10/04/20.
//  Copyright © 2020 reliae. All rights reserved.
//

class Product: Codable {
    let id: String?
    let uniqueId: Int?
    let storeId: String?
    let imageURL: String?
    let isVisibleInStore: Bool?
    let details, name: String?
    let items: [ProductItem]?

    enum CodingKeys: String, CodingKey {
        case id
        case uniqueId = "unique_id"
        case storeId = "store_id"
        case imageURL = "image_url"
        case isVisibleInStore = "is_visible_in_store"
        case details, name, items
    }

    init(id: String?, uniqueId: Int?, storeId: String?, imageURL: String?, isVisibleInStore: Bool?, details: String?, name: String?, items: [ProductItem]?) {
        self.id = id
        self.uniqueId = uniqueId
        self.storeId = storeId
        self.imageURL = imageURL
        self.isVisibleInStore = isVisibleInStore
        self.details = details
        self.name = name
        self.items = items
    }
}
