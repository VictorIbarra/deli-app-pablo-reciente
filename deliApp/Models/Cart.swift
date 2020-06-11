//
//  Cart.swift
//  deliApp
//
//  Created by iJPe on 11/26/18.
//  Copyright © 2018 reliae. All rights reserved.
//

import Foundation
import UIKit
import CoreData
import CoreLocation

// MARK: - Cart
class Cart: CartBase {
    var cityID: String?
    var createdAt: String?
    var isDefault: Bool?
    var orderID, orderPaymentID: String?
    var totalCartPrice: Double?
    var totalItemCount, uniqueId: Int?
    var updatedAt: String?
    var store: Store?
    
    var address: CartAddress {
        get {
            return destinationAddresses!.count > 0 ? destinationAddresses![0] : CartAddress()
        }
        set {
            destinationAddresses![0] = newValue
        }
    }
    
    var addressText: String {
        get {
            return destinationAddresses!.count > 0 ? destinationAddresses![0].address! : ""
        }
        set {
            destinationAddresses![0].address = newValue
        }
    }
    
    var addressLocation: CLLocationCoordinate2D! {
        get {
            if destinationAddresses![0].location?.count ?? 0 > 0 {
                return CLLocationCoordinate2D(latitude: destinationAddresses![0].location![0], longitude: destinationAddresses![0].location![1])
            }
            return nil
        }
        set {
            destinationAddresses![0].location = [newValue.latitude, newValue.longitude]
        }
    }
    
    var productQuantity: Int {
        var q = 0
        orderDetails?.forEach { (detail) in
            q += detail.items?.count ?? 0
        }
        return q
    }
    
    var total: Double {
        var total = 0.0
        orderDetails?.forEach { (detail) in
            total = detail.totalItemPrice!
        }
        return total
    }
    
    private enum CodingKeys: String, CodingKey {
        case cartUniqueToken = "cart_unique_token"
        case cityID = "city_id"
        case createdAt = "created_at"
        case destinationAddresses = "destination_addresses"
        case isDefault = "is_default"
        case orderDetails = "order_details"
        case orderID = "order_id"
        case orderPaymentID = "order_payment_id"
        case pickupAddresses = "pickup_addresses"
        case storeId = "store_id"
        case totalCartPrice = "total_cart_price"
        case totalItemCount = "total_item_count"
        case uniqueId = "unique_id"
        case updatedAt = "updated_at"
        case userID = "user_id"
        case userType = "user_type"
        case userTypeID = "user_type_id"
        case store
    }
    
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        if let cityID = try container.decodeIfPresent(String.self, forKey: .cityID) {
            self.cityID = cityID
        }
        if let createdAt = try container.decodeIfPresent(String.self, forKey: .createdAt) {
            self.createdAt = createdAt
        }
        if let isDefault = try container.decodeIfPresent(Bool.self, forKey: .isDefault) {
            self.isDefault = isDefault
        }
        if let orderPaymentID = try container.decodeIfPresent(String.self, forKey: .orderPaymentID) {
            self.orderPaymentID = orderPaymentID
        }
        if let totalCartPrice = try container.decodeIfPresent(Double.self, forKey: .totalCartPrice) {
            self.totalCartPrice = totalCartPrice
        }
        if let totalItemCount = try container.decodeIfPresent(Int.self, forKey: .totalItemCount) {
            self.totalItemCount = totalItemCount
        }
        if let uniqueId = try container.decodeIfPresent(Int.self, forKey: .uniqueId) {
            self.uniqueId = uniqueId
        }
        if let updatedAt = try container.decodeIfPresent(String.self, forKey: .updatedAt) {
            self.updatedAt = updatedAt
        }
        if let store = try container.decodeIfPresent(Store.self, forKey: .store) {
            self.store = store
        }
    }
    
    init(id: String?, cartUniqueToken: String?, cityID: String?, createdAt: String?, destinationAddresses: [CartAddress]?, isDefault: Bool?, orderDetails: [OrderDetail]?, orderID: String?, orderPaymentID: String?, pickupAddresses: [CartPickupAddress]?, storeId: String?, totalCartPrice: Double?, totalItemCount: Int?, uniqueId: Int?, updatedAt: String?, userID: String?, userType: Int?, userTypeID: String?, store: Store?) {
        super.init(id: id, cartUniqueToken: cartUniqueToken, destinationAddresses: destinationAddresses, orderDetails: orderDetails, pickupAddresses: pickupAddresses, storeId: storeId, uniqueId: uniqueId, userID: userID, userType: userType, userTypeID: userTypeID)
        super.id = id
        super.cartUniqueToken = cartUniqueToken
        self.cityID = cityID
        self.createdAt = createdAt
        super.destinationAddresses = destinationAddresses
        self.isDefault = isDefault
        super.orderDetails = orderDetails
        self.orderID = orderID
        self.orderPaymentID = orderPaymentID
        super.pickupAddresses = pickupAddresses
        self.storeId = storeId
        self.totalCartPrice = totalCartPrice
        self.totalItemCount = totalItemCount
        self.uniqueId = uniqueId
        self.updatedAt = updatedAt
        self.userID = userID
        self.userType = userType
        self.userTypeID = userTypeID
        self.store = store
    }
    
    func remove(indexOrderDetail: Int, indexItem: Int) {
        orderDetails![indexOrderDetail].totalItemPrice = orderDetails![indexOrderDetail].totalItemPrice! - orderDetails![indexOrderDetail].items![indexItem].totalItemAndSpecificationPrice!
        orderDetails![indexOrderDetail].items?.remove(at: indexItem)
        
        if orderDetails![indexOrderDetail].items?.count ?? 0 <= 0 {
            Identity.shared.cart.data?.orderDetails?.remove(at: indexOrderDetail)
        }
    }
    
    func build() -> CartBase {
        let cart = CartBase()
        cart.cartUniqueToken = ""
        cart.userType = 7
        cart.userID = Identity.shared.user!.id
        cart.serverToken = Identity.shared.user!.serverToken
        cart.paymentID = "5b07af95ed9e442a6ed6d061"
        cart.storeId = self.storeId!
        
        self.orderDetails?.forEach { (orderDetail) in
            let detail = OrderDetail()
            detail.totalItemPrice = 0.0
            
            orderDetail.items?.forEach { (item) in
                let i = Item()
                i.specifications = []
                item.specifications?.forEach { (specification) in
                    let s = Specification()
                    s.list = []
                    specification.list.forEach { (list) in
                        let l = ItemSpecification()
                        l.isDefaultSelected = list.isDefaultSelected
                        l.uniqueId = list.uniqueId
                        l.id = list.id
                        l.price = list.price
                        l.name = list.name
                        l.isUserSelected = list.isUserSelected
                        s.list.append(l)
                    }
                    
                    s.price = specification.price
                    s.type = specification.type
                    s.name = specification.name
                    s.uniqueId = specification.uniqueId
                    i.specifications?.append(s)
                }
                
                i.quantity = item.quantity!
                i.itemName = item.itemName!
                i.imageURL = []
                i.itemID = item.itemID!
                i.details = item.details!
                i.totalItemAndSpecificationPrice = item.totalItemAndSpecificationPrice
                i.maxItemQuantity = item.maxItemQuantity!
                i.noteForItem = item.noteForItem!
                i.totalSpecificationPrice = item.totalSpecificationPrice
                i.uniqueId = item.uniqueId!
                i.itemPrice = item.itemPrice
                detail.totalItemPrice = (detail.totalItemPrice! + i.itemPrice!) * Double(i.quantity!)
                detail.items?.append(i)
            }
            
            detail.productId = orderDetail.productId!
            detail.uniqueId = orderDetail.uniqueId!
            detail.productName = orderDetail.productName!
            detail.totalItemPrice = orderDetail.totalItemPrice
            cart.orderDetails?.append(detail)
        }
        
        //Destination
        let destination_addresses = CartAddress()
        destination_addresses.address = self.destinationAddresses![0].address!
        destination_addresses.addressType = "destination"
        destination_addresses.city = self.destinationAddresses![0].city!
        destination_addresses.location = self.destinationAddresses![0].location!
        destination_addresses.note = self.destinationAddresses![0].note!
        destination_addresses.userType = 7
        
        let user_details = UserDetail()
        user_details.email = self.destinationAddresses![0].userDetails!.email!
        user_details.name = self.destinationAddresses![0].userDetails!.name!
        user_details.phone = self.destinationAddresses![0].userDetails!.phone!
        destination_addresses.userDetails = user_details
        
        //Pickup
        let pickup_addresses = CartPickupAddress()
        pickup_addresses.address = self.pickupAddresses![0].address!
        pickup_addresses.addressType = "pickup"
        pickup_addresses.city = self.pickupAddresses![0].city!
        pickup_addresses.deliveryStatus = 0
        pickup_addresses.location = self.pickupAddresses![0].location!
        pickup_addresses.note = self.pickupAddresses![0].note!
        pickup_addresses.userType = 7
        pickup_addresses.userDetails = self.pickupAddresses![0].userDetails!
        
        cart.id = self.id!
        cart.destinationAddresses?.append(destination_addresses)
        cart.pickupAddresses?.append(pickup_addresses)
        return cart
    }
}
