//
//  Item.swift
//  deliApp
//
//  Created by iJPe on 6/27/19.
//  Copyright © 2019 reliae. All rights reserved.
//

import Foundation

// MARK: - Item
class Item: Codable {
    var quantity: Int?
    var specifications: [Specification]?
    var itemName: String?
    var itemPrice: Double?
    var imageURL: [String]?
    var details: String?
    var totalItemAndSpecificationPrice, totalSpecificationPrice: Double?
    var maxItemQuantity: Int? = 10
    var itemID: String?
    var uniqueId: Int?
    var noteForItem: String?
    
    enum CodingKeys: String, CodingKey {
        case quantity, specifications
        case itemName = "item_name"
        case itemPrice = "item_price"
        case imageURL = "image_url"
        case details
        case totalItemAndSpecificationPrice = "total_item_and_specification_price"
        case maxItemQuantity = "max_item_quantity"
        case totalSpecificationPrice = "total_specification_price"
        case itemID = "item_id"
        case uniqueId = "unique_id"
        case noteForItem = "note_for_item"
    }
    
    init() {
    }
    
    init(quantity: Int?, specifications: [Specification]?, itemName: String?, itemPrice: Double?, imageURL: [String]?, details: String?, totalItemAndSpecificationPrice: Double?, maxItemQuantity: Int?, totalSpecificationPrice: Double?, itemID: String?, uniqueId: Int?, noteForItem: String?) {
        self.quantity = quantity
        self.specifications = specifications
        self.itemName = itemName
        self.itemPrice = itemPrice
        self.imageURL = imageURL
        self.details = details
        self.totalItemAndSpecificationPrice = totalItemAndSpecificationPrice
        self.maxItemQuantity = maxItemQuantity
        self.totalSpecificationPrice = totalSpecificationPrice
        self.itemID = itemID
        self.uniqueId = uniqueId
        self.noteForItem = noteForItem
    }
}

