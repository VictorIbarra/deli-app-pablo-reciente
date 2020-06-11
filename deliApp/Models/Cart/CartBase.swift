//
//  CartBase.swift
//  deliApp
//
//  Created by iJPe on 10/04/20.
//  Copyright © 2020 reliae. All rights reserved.
//

import Foundation
import UIKit

class CartBase: NSObject, Codable {
    var id: String? = ""
    var cartUniqueToken: String? = ""
    var userTypeID: String? = ""
    var userType: Int? = 0
    var userID: String? = ""
    var serverToken: String? = ""
    var paymentID: String? = Env.Deli.defaultPaymentId
    var storeId: String? = ""
    var orderDetails: [OrderDetail]? = []
    var destinationAddresses: [CartAddress]? = []
    var pickupAddresses: [CartPickupAddress]? = []
    
    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case cartUniqueToken = "cart_unique_token"
        case destinationAddresses = "destination_addresses"
        case orderDetails = "order_details"
        case paymentID = "payment_id"
        case pickupAddresses = "pickup_addresses"
        case storeId = "store_id"
        case userID = "user_id"
        case userType = "user_type"
        case userTypeID = "user_type_id"
    }
    
    override init() {
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        if let id = try container.decodeIfPresent(String.self, forKey: .id) {
            self.id = id
        }
        if let cartUniqueToken = try container.decodeIfPresent(String.self, forKey: .cartUniqueToken) {
            self.cartUniqueToken = cartUniqueToken
        }
        if let destinationAddresses = try container.decodeIfPresent([CartAddress].self, forKey: .destinationAddresses) {
            self.destinationAddresses = destinationAddresses
        }
        if let orderDetails = try container.decodeIfPresent([OrderDetail].self, forKey: .orderDetails) {
            self.orderDetails = orderDetails
        }
        if let pickupAddresses = try container.decodeIfPresent([CartPickupAddress].self, forKey: .pickupAddresses) {
            self.pickupAddresses = pickupAddresses
        }
        if let storeId = try container.decodeIfPresent(String.self, forKey: .storeId) {
            self.storeId = storeId
        }
        if let userID = try container.decodeIfPresent(String.self, forKey: .userID) {
            self.userID = userID
        }
        if let userType = try container.decodeIfPresent(Int.self, forKey: .userType) {
            self.userType = userType
        }
        if let userTypeID = try container.decodeIfPresent(String.self, forKey: .userTypeID) {
            self.userTypeID = userTypeID
        }
    }
    
    init(id: String?, cartUniqueToken: String?, destinationAddresses: [CartAddress]?, orderDetails: [OrderDetail]?, pickupAddresses: [CartPickupAddress]?, storeId: String?, uniqueId: Int?, userID: String?, userType: Int?, userTypeID: String?) {
        self.id = id
        self.cartUniqueToken = cartUniqueToken
        self.destinationAddresses = destinationAddresses
        self.orderDetails = orderDetails
        self.pickupAddresses = pickupAddresses
        self.storeId = storeId
        self.userID = userID
        self.userType = userType
        self.userTypeID = userTypeID
    }
    
    func getJson() -> [String : Any]! {
        let encodedObject = try? JSONEncoder().encode(self)
        if let jsonString = String(data: encodedObject!, encoding: .utf8)
        {
            do {
                let objectData = jsonString.data(using: String.Encoding.utf8)
                let json = try JSONSerialization.jsonObject(with: objectData!, options: JSONSerialization.ReadingOptions.mutableContainers)
                return json as? [String : Any]
            } catch _ as NSError {
                return  nil
            }
        }
        return nil
    }
}
