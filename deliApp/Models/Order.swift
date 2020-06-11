//
//  Order.swift
//  deliApp
//
//  Created by iJPe on 7/30/19.
//  Copyright © 2019 reliae. All rights reserved.
//

import Foundation

// MARK: - Order
class Order: Codable {
    var id, cancelReason, cartID, cityID: String?
    var completedAt: String?
    var confirmationCodeForCompleteDelivery, confirmationCodeForPickUpDelivery: Int?
    var countryID, createdAt: String?
    var dateTime: [DateTime]?
    var estimatedTimeForReadyOrder: Double?
    var isProviderRatedToStore, isProviderRatedToUser, isProviderShowInvoice, isScheduleOrder: Bool?
    var isScheduleOrderInformedToStore, isStoreRatedToProvider, isStoreRatedToUser, isUserRatedToProvider: Bool?
    var isUserRatedToStore, isUserShowInvoice: Bool?
    var orderPaymentID: String?
    var orderStatus: Int?
    var orderStatusBy: String?
    var orderStatusID, orderStatusManageID, orderType: Int?
    var orderTypeID: String?
    var requestID, scheduleOrderServerStartAt, scheduleOrderStartAt: String?
    var storeId: String?
    var storeNotify: Int?
    var timezone: String?
    var uniqueId: Int?
    var updatedAt, userID: String?
    var orderPayment: OrderPayment?
    var store: Store?
    var cart: Cart?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case cancelReason = "cancel_reason"
        case cartID = "cart_id"
        case cityID = "city_id"
        case completedAt = "completed_at"
        case confirmationCodeForCompleteDelivery = "confirmation_code_for_complete_delivery"
        case confirmationCodeForPickUpDelivery = "confirmation_code_for_pick_up_delivery"
        case countryID = "country_id"
        case createdAt = "created_at"
        case dateTime = "date_time"
        case estimatedTimeForReadyOrder = "estimated_time_for_ready_order"
        case isProviderRatedToStore = "is_provider_rated_to_store"
        case isProviderRatedToUser = "is_provider_rated_to_user"
        case isProviderShowInvoice = "is_provider_show_invoice"
        case isScheduleOrder = "is_schedule_order"
        case isScheduleOrderInformedToStore = "is_schedule_order_informed_to_store"
        case isStoreRatedToProvider = "is_store_rated_to_provider"
        case isStoreRatedToUser = "is_store_rated_to_user"
        case isUserRatedToProvider = "is_user_rated_to_provider"
        case isUserRatedToStore = "is_user_rated_to_store"
        case isUserShowInvoice = "is_user_show_invoice"
        case orderPaymentID = "order_payment_id"
        case orderStatus = "order_status"
        case orderStatusBy = "order_status_by"
        case orderStatusID = "order_status_id"
        case orderStatusManageID = "order_status_manage_id"
        case orderType = "order_type"
        case orderTypeID = "order_type_id"
        case requestID = "request_id"
        case scheduleOrderServerStartAt = "schedule_order_server_start_at"
        case scheduleOrderStartAt = "schedule_order_start_at"
        case storeId = "store_id"
        case storeNotify = "store_notify"
        case timezone
        case uniqueId = "unique_id"
        case updatedAt = "updated_at"
        case userID = "user_id"
        case orderPayment = "order_payment"
        case store
        case cart
    }
    
    required init(from decoder: Decoder) throws {
        var container = try decoder.container(keyedBy: CodingKeys.self)
        
        if let id = try container.decodeIfPresent(String.self, forKey: .id) {
            self.id = id
        }
        if let cancelReason = try container.decodeIfPresent(String.self, forKey: .cancelReason) {
            self.cancelReason = cancelReason
        }
        if let cartID = try container.decodeIfPresent(String.self, forKey: .cartID) {
            self.cartID = cartID
        }
        if let cityID = try container.decodeIfPresent(String.self, forKey: .cityID) {
            self.cityID = cityID
        }
        if let completedAt = try container.decodeIfPresent(String.self, forKey: .completedAt) {
            self.completedAt = completedAt
        }
        if let confirmationCodeForCompleteDelivery = try container.decodeIfPresent(Int.self, forKey: .confirmationCodeForCompleteDelivery) {
            self.confirmationCodeForCompleteDelivery = confirmationCodeForCompleteDelivery
        }
        if let confirmationCodeForPickUpDelivery = try container.decodeIfPresent(Int.self, forKey: .confirmationCodeForPickUpDelivery) {
            self.confirmationCodeForPickUpDelivery = confirmationCodeForPickUpDelivery
        }
        if let countryID = try container.decodeIfPresent(String.self, forKey: .countryID) {
            self.countryID = countryID
        }
        if let createdAt = try container.decodeIfPresent(String.self, forKey: .createdAt) {
            self.createdAt = createdAt
        }
        if let dateTime  = try container.decodeIfPresent([DateTime].self, forKey: .dateTime ) {
            self.dateTime = dateTime
        }
        if let estimatedTimeForReadyOrder = try container.decodeIfPresent(Double.self, forKey: .estimatedTimeForReadyOrder) {
            self.estimatedTimeForReadyOrder = estimatedTimeForReadyOrder
        }
        if let isProviderRatedToStore = try container.decodeIfPresent(Bool.self, forKey: .isProviderRatedToStore) {
            self.isProviderRatedToStore = isProviderRatedToStore
        }
        if let isProviderRatedToUser = try container.decodeIfPresent(Bool.self, forKey: .isProviderRatedToUser) {
            self.isProviderRatedToUser = isProviderRatedToUser
        }
        if let isProviderShowInvoice = try container.decodeIfPresent(Bool.self, forKey: .isProviderShowInvoice) {
            self.isProviderShowInvoice = isProviderShowInvoice
        }
        if let isScheduleOrder = try container.decodeIfPresent(Bool.self, forKey: .isScheduleOrder) {
            self.isScheduleOrder = isScheduleOrder
        }
        if let isScheduleOrderInformedToStore = try container.decodeIfPresent(Bool.self, forKey: .isScheduleOrderInformedToStore) {
            self.isScheduleOrderInformedToStore = isScheduleOrderInformedToStore
        }
        if let isStoreRatedToProvider = try container.decodeIfPresent(Bool.self, forKey: .isStoreRatedToProvider) {
            self.isStoreRatedToProvider = isStoreRatedToProvider
        }
        if let isStoreRatedToUser = try container.decodeIfPresent(Bool.self, forKey: .isStoreRatedToUser) {
            self.isStoreRatedToUser = isStoreRatedToUser
        }
        if let isUserRatedToProvider = try container.decodeIfPresent(Bool.self, forKey: .isUserRatedToProvider) {
            self.isUserRatedToProvider = isUserRatedToProvider
        }
        if let isUserRatedToStore = try container.decodeIfPresent(Bool.self, forKey: .isUserRatedToStore) {
            self.isUserRatedToStore = isUserRatedToStore
        }
        if let isUserShowInvoice = try container.decodeIfPresent(Bool.self, forKey: .isUserShowInvoice) {
            self.isUserShowInvoice = isUserShowInvoice
        }
        if let orderPaymentID = try container.decodeIfPresent(String.self, forKey: .orderPaymentID) {
            self.orderPaymentID = orderPaymentID
        }
        if let orderStatus = try container.decodeIfPresent(Int.self, forKey: .orderStatus) {
            self.orderStatus = orderStatus
        }
        if let orderStatusBy = try container.decodeIfPresent(String.self, forKey: .orderStatusBy) {
            self.orderStatusBy = orderStatusBy
        }
        if let orderStatusID = try container.decodeIfPresent(Int.self, forKey: .orderStatusID) {
            self.orderStatusID = orderStatusID
        }
        if let orderStatusManageID = try container.decodeIfPresent(Int.self, forKey: .orderStatusManageID) {
            self.orderStatusManageID = orderStatusManageID
        }
        if let orderType = try container.decodeIfPresent(Int.self, forKey: .orderType) {
            self.orderType = orderType
        }
        if let orderTypeID = try container.decodeIfPresent(String.self, forKey: .orderTypeID) {
            self.orderTypeID = orderTypeID
        }
        if let requestID = try container.decodeIfPresent(String.self, forKey: .requestID) {
            self.requestID = requestID
        }
        if let scheduleOrderServerStartAt = try container.decodeIfPresent(String.self, forKey: .scheduleOrderServerStartAt) {
            self.scheduleOrderServerStartAt = scheduleOrderServerStartAt
        }
        if let scheduleOrderStartAt = try container.decodeIfPresent(String.self, forKey: .scheduleOrderStartAt) {
            self.scheduleOrderStartAt = scheduleOrderStartAt
        }
        if let storeId = try container.decodeIfPresent(String.self, forKey: .storeId) {
            self.storeId = storeId
        }
        if let storeNotify = try container.decodeIfPresent(Int.self, forKey: .storeNotify) {
            self.storeNotify = storeNotify
        }
        if let timezone = try container.decodeIfPresent(String.self, forKey: .timezone) {
            self.timezone = timezone
        }
        if let uniqueId = try container.decodeIfPresent(Int.self, forKey: .uniqueId) {
            self.uniqueId = uniqueId
        }
        if let updatedAt = try container.decodeIfPresent(String.self, forKey: .updatedAt) {
            self.updatedAt = updatedAt
        }
        if let userID = try container.decodeIfPresent(String.self, forKey: .userID) {
            self.userID = userID
        }
        if let orderPayment = try container.decodeIfPresent(OrderPayment.self, forKey: .orderPayment) {
            self.orderPayment = orderPayment
        }
        if let store = try container.decodeIfPresent(Store.self, forKey: .store) {
            self.store = store
        }
        if let cart = try container.decodeIfPresent(Cart.self, forKey: .cart) {
            self.cart = cart
        }
    }
    
    init(id: String?, cancelReason: String?, cartID: String?, cityID: String?, completedAt: String?, confirmationCodeForCompleteDelivery: Int?, confirmationCodeForPickUpDelivery: Int?, countryID: String?, createdAt: String?, dateTime: [DateTime]?, estimatedTimeForReadyOrder: Double?, isProviderRatedToStore: Bool?, isProviderRatedToUser: Bool?, isProviderShowInvoice: Bool?, isScheduleOrder: Bool?, isScheduleOrderInformedToStore: Bool?, isStoreRatedToProvider: Bool?, isStoreRatedToUser: Bool?, isUserRatedToProvider: Bool?, isUserRatedToStore: Bool?, isUserShowInvoice: Bool?, orderPaymentID: String?, orderStatus: Int?, orderStatusBy: String?, orderStatusID: Int?, orderStatusManageID: Int?, orderType: Int?, orderTypeID: String?, requestID: String?, scheduleOrderServerStartAt: String?, scheduleOrderStartAt: String?, storeId: String?, storeNotify: Int?, timezone: String?, uniqueId: Int?, updatedAt: String?, userID: String?, orderPayment: OrderPayment?, store: Store?, cart: Cart?) {
        self.id = id
        self.cancelReason = cancelReason
        self.cartID = cartID
        self.cityID = cityID
        self.completedAt = completedAt
        self.confirmationCodeForCompleteDelivery = confirmationCodeForCompleteDelivery
        self.confirmationCodeForPickUpDelivery = confirmationCodeForPickUpDelivery
        self.countryID = countryID
        self.createdAt = createdAt
        self.dateTime = dateTime
        self.estimatedTimeForReadyOrder = estimatedTimeForReadyOrder
        self.isProviderRatedToStore = isProviderRatedToStore
        self.isProviderRatedToUser = isProviderRatedToUser
        self.isProviderShowInvoice = isProviderShowInvoice
        self.isScheduleOrder = isScheduleOrder
        self.isScheduleOrderInformedToStore = isScheduleOrderInformedToStore
        self.isStoreRatedToProvider = isStoreRatedToProvider
        self.isStoreRatedToUser = isStoreRatedToUser
        self.isUserRatedToProvider = isUserRatedToProvider
        self.isUserRatedToStore = isUserRatedToStore
        self.isUserShowInvoice = isUserShowInvoice
        self.orderPaymentID = orderPaymentID
        self.orderStatus = orderStatus
        self.orderStatusBy = orderStatusBy
        self.orderStatusID = orderStatusID
        self.orderStatusManageID = orderStatusManageID
        self.orderType = orderType
        self.orderTypeID = orderTypeID
        self.requestID = requestID
        self.scheduleOrderServerStartAt = scheduleOrderServerStartAt
        self.scheduleOrderStartAt = scheduleOrderStartAt
        self.storeId = storeId
        self.storeNotify = storeNotify
        self.timezone = timezone
        self.uniqueId = uniqueId
        self.updatedAt = updatedAt
        self.userID = userID
        self.orderPayment = orderPayment
        self.store = store
        self.cart = cart
    }
}
