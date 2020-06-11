//
//  StoreSummary.swift
//  deliApp
//
//  Created by iJPe on 7/18/19.
//  Copyright © 2019 reliae. All rights reserved.
//

import Foundation

// MARK: - Store
class StoreSummary: Codable {
    var id, address: String?
    var deliveryRadius, deliveryTime, deliveryTimeMax: Int?
    var distance: Double?
    var imageURL: String?
    var location: [Double]?
    var maxItemQuantityAddByUser, minOrderPrice: Int?
    var name: String?
    var phone: String?
    var priceRating: Int?
    var storeDeliveryID: String?
    var userRate: Int?
    var walletCurrencyCode: String?
    var websiteURL: String?
    var isOpenNow: Bool?
    
    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case address
        case deliveryRadius = "delivery_radius"
        case deliveryTime = "delivery_time"
        case deliveryTimeMax = "delivery_time_max"
        case distance = "distance"
        case imageURL = "image_url"
        case location
        case maxItemQuantityAddByUser = "max_item_quantity_add_by_user"
        case minOrderPrice = "min_order_price"
        case name, phone
        case priceRating = "price_rating"
        case storeDeliveryID = "store_delivery_id"
        case userRate = "user_rate"
        case walletCurrencyCode = "wallet_currency_code"
        case websiteURL = "website_url"
        case isOpenNow = "is_open_now"
    }
    
    init() {
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        if let id = try container.decodeIfPresent(String.self, forKey: .id) {
            self.id = id
        }
        if let address = try container.decodeIfPresent(String.self, forKey: .address) {
            self.address = address
        }
        if let deliveryRadius = try container.decodeIfPresent(Int.self, forKey: .deliveryRadius) {
            self.deliveryRadius = deliveryRadius
        }
        if let deliveryTime = try container.decodeIfPresent(Int.self, forKey: .deliveryTime) {
            self.deliveryTime = deliveryTime
        }
        if let deliveryTimeMax = try container.decodeIfPresent(Int.self, forKey: .deliveryTimeMax) {
            self.deliveryTimeMax = deliveryTimeMax
        }
        if let distance = try container.decodeIfPresent(Double.self, forKey: .distance) {
            self.distance = distance
        }
        if let imageURL = try container.decodeIfPresent(String.self, forKey: .imageURL) {
            self.imageURL = imageURL
        }
        if let location = try container.decodeIfPresent([Double].self, forKey: .location) {
            self.location = location
        }
        if let maxItemQuantityAddByUser = try container.decodeIfPresent(Int.self, forKey: .maxItemQuantityAddByUser) {
            self.maxItemQuantityAddByUser = maxItemQuantityAddByUser
        }
        if let minOrderPrice = try container.decodeIfPresent(Int.self, forKey: .minOrderPrice) {
            self.minOrderPrice = minOrderPrice
        }
        if let name = try container.decodeIfPresent(String.self, forKey: .name) {
            self.name = name
        }
        if let phone = try container.decodeIfPresent(String.self, forKey: .phone) {
            self.phone = phone
        }
        if let priceRating = try container.decodeIfPresent(Int.self, forKey: .priceRating) {
            self.priceRating = priceRating
        }
        if let storeDeliveryID = try container.decodeIfPresent(String.self, forKey: .storeDeliveryID) {
            self.storeDeliveryID = storeDeliveryID
        }
        if let userRate = try container.decodeIfPresent(Int.self, forKey: .userRate) {
            self.userRate = userRate
        }
        if let walletCurrencyCode = try container.decodeIfPresent(String.self, forKey: .walletCurrencyCode) {
            self.walletCurrencyCode = walletCurrencyCode
        }
        if let websiteURL = try container.decodeIfPresent(String.self, forKey: .websiteURL) {
            self.websiteURL = websiteURL
        }
        if let isOpenNow = try container.decodeIfPresent(Bool.self, forKey: .isOpenNow) {
            self.isOpenNow = isOpenNow
        }
    }
    
    init(v: Int?, id: String?, address: String?, deliveryRadius: Int?, deliveryTime: Int?, deliveryTimeMax: Int?, distance: Double?, imageURL: String?, location: [Double]?, maxItemQuantityAddByUser: Int?, minOrderPrice: Int?, name: String?, phone: String?, priceRating: Int?, storeDeliveryID: String?, userRate: Int?, walletCurrencyCode: String?, websiteURL: String?, isOpenNow: Bool?) {
        self.id = id
        self.address = address
        self.deliveryRadius = deliveryRadius
        self.deliveryTime = deliveryTime
        self.deliveryTimeMax = deliveryTimeMax
        self.distance = distance
        self.imageURL = imageURL
        self.location = location
        self.maxItemQuantityAddByUser = maxItemQuantityAddByUser
        self.minOrderPrice = minOrderPrice
        self.name = name
        self.phone = phone
        self.priceRating = priceRating
        self.storeDeliveryID = storeDeliveryID
        self.userRate = userRate
        self.walletCurrencyCode = walletCurrencyCode
        self.websiteURL = websiteURL
        self.isOpenNow = isOpenNow
    }
}
