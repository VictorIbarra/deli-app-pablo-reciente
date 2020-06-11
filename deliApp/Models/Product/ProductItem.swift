//
//  ProductItem.swift
//  deliApp
//
//  Created by iJPe on 10/04/20.
//  Copyright © 2020 reliae. All rights reserved.
//

class ProductItem: Codable {
    let id: String?
    let uniqueId: Int?
    let storeId: String?
    let imageURL: [String]?
    let specifications: [ProductSpecification]?
    let specificationsUniqueIDCount: Int?
    let totalPrice, totalSpecificationPrice, totalItemPrice: Double?
    let isVisibleInStore, isMostPopular, isItemInStock: Bool?
    let noteForItem: String?
    let totalUsedQuantity, totalAddedQuantity: Int?
    let inCartQuantity: Bool?
    let totalQuantity: Int?
    let itemPriceWithoutOffer: Double?
    let offerMessageOrPercentage: String?
    let price: Double?
    let name, details: String?

    enum CodingKeys: String, CodingKey {
        case id
        case uniqueId = "unique_id"
        case storeId = "store_id"
        case imageURL = "image_url"
        case specifications
        case specificationsUniqueIDCount = "specifications_unique_id_count"
        case totalPrice = "total_price"
        case totalSpecificationPrice = "total_specification_price"
        case totalItemPrice = "total_item_price"
        case isVisibleInStore = "is_visible_in_store"
        case isMostPopular = "is_most_popular"
        case isItemInStock = "is_item_in_stock"
        case noteForItem = "note_for_item"
        case totalUsedQuantity = "total_used_quantity"
        case totalAddedQuantity = "total_added_quantity"
        case inCartQuantity = "in_cart_quantity"
        case totalQuantity = "total_quantity"
        case itemPriceWithoutOffer = "item_price_without_offer"
        case offerMessageOrPercentage = "offer_message_or_percentage"
        case price, name, details
    }

    init(id: String?, uniqueId: Int?, storeId: String?, imageURL: [String]?, specifications: [ProductSpecification]?, specificationsUniqueIDCount: Int?, totalPrice: Double?, totalSpecificationPrice: Double?, totalItemPrice: Double?, isVisibleInStore: Bool?, isMostPopular: Bool?, isItemInStock: Bool?, noteForItem: String?, totalUsedQuantity: Int?, totalAddedQuantity: Int?, inCartQuantity: Bool?, totalQuantity: Int?, itemPriceWithoutOffer: Double?, offerMessageOrPercentage: String?, price: Double?, name: String?, details: String?) {
        self.id = id
        self.uniqueId = uniqueId
        self.storeId = storeId
        self.imageURL = imageURL
        self.specifications = specifications
        self.specificationsUniqueIDCount = specificationsUniqueIDCount
        self.totalPrice = totalPrice
        self.totalSpecificationPrice = totalSpecificationPrice
        self.totalItemPrice = totalItemPrice
        self.isVisibleInStore = isVisibleInStore
        self.isMostPopular = isMostPopular
        self.isItemInStock = isItemInStock
        self.noteForItem = noteForItem
        self.totalUsedQuantity = totalUsedQuantity
        self.totalAddedQuantity = totalAddedQuantity
        self.inCartQuantity = inCartQuantity
        self.totalQuantity = totalQuantity
        self.itemPriceWithoutOffer = itemPriceWithoutOffer
        self.offerMessageOrPercentage = offerMessageOrPercentage
        self.price = price
        self.name = name
        self.details = details
    }
}
