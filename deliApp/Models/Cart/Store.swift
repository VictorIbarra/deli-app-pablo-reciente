//
//  Store.swift
//  deliApp
//
//  Created by iJPe on 6/27/19.
//  Copyright © 2019 reliae. All rights reserved.
//

import Foundation

// MARK: - Store
class Store: StoreSummary {
    var accountID: String?
    var adminProfitModeOnStore, adminProfitValueOnStore, adminType: Int?
    var appVersion, bankID, cityID, comments: String?
    var countryID, countryPhoneCode, createdAt: String?
    var deviceToken, deviceType, email: String?
    var famousProductsTags: [String]?
    var freeDeliveryForAboveOrderPrice, freeDeliveryWithinRadius: Int?
    var informScheduleOrderBeforeMin: Int?
    var isApproved, isAskEstimatedTimeForReadyOrder, isBusiness, isDocumentUploaded: Bool?
    var isEmailVerified, isOrderCancellationChargeApply, isPhoneNumberVerified, isProvideDeliveryAnywhere: Bool?
    var isReferral, isStoreBusy, isStorePayDeliveryFees, isTakingScheduleOrder: Bool?
    var isVisible: Bool?
    var itemTax: Int?
    var locationLatitude, locationLongitude: Double?
    var loginBy: String?
    var openpayID: String?
    var orderCancellationChargeForAboveOrderPrice, orderCancellationChargeType, orderCancellationChargeValue: Int?
    var password: String?
    var providerRate, providerRateCount: Int?
    var referralCode, referredBy: String?
    var scheduleOrderCreateAfterMinute: Int?
    var serverToken, slogan: String?
    var socialIDS: [String]?
    var storeRateCount: Int?
    var storeTime: [StoreTime]?
    var storeType: Int?
    var storeTypeID: String?
    var totalReferrals, uniqueId: Int?
    var updatedAt: String?
    var userRateCount, wallet: Int?
    
    private enum CodingKeys: String, CodingKey {
        case accountID = "account_id"
        case adminProfitModeOnStore = "admin_profit_mode_on_store"
        case adminProfitValueOnStore = "admin_profit_value_on_store"
        case adminType = "admin_type"
        case appVersion = "app_version"
        case bankID = "bank_id"
        case cityID = "city_id"
        case comments
        case countryID = "country_id"
        case countryPhoneCode = "country_phone_code"
        case createdAt = "created_at"
        case deviceToken = "device_token"
        case deviceType = "device_type"
        case email
        case famousProductsTags = "famous_products_tags"
        case freeDeliveryForAboveOrderPrice = "free_delivery_for_above_order_price"
        case freeDeliveryWithinRadius = "free_delivery_within_radius"
        case imageURL = "image_url"
        case informScheduleOrderBeforeMin = "inform_schedule_order_before_min"
        case isApproved = "is_approved"
        case isAskEstimatedTimeForReadyOrder = "is_ask_estimated_time_for_ready_order"
        case isBusiness = "is_business"
        case isDocumentUploaded = "is_document_uploaded"
        case isEmailVerified = "is_email_verified"
        case isOrderCancellationChargeApply = "is_order_cancellation_charge_apply"
        case isPhoneNumberVerified = "is_phone_number_verified"
        case isProvideDeliveryAnywhere = "is_provide_delivery_anywhere"
        case isReferral = "is_referral"
        case isStoreBusy = "is_store_busy"
        case isStorePayDeliveryFees = "is_store_pay_delivery_fees"
        case isTakingScheduleOrder = "is_taking_schedule_order"
        case isVisible = "is_visible"
        case itemTax = "item_tax"
        case location
        case locationLatitude = "location_latitude"
        case locationLongitude = "location_longitude"
        case loginBy = "login_by"
        case maxItemQuantityAddByUser = "max_item_quantity_add_by_user"
        case minOrderPrice = "min_order_price"
        case name
        //        case storeOffers = "offers"
        case openpayID = "openpay_id"
        case orderCancellationChargeForAboveOrderPrice = "order_cancellation_charge_for_above_order_price"
        case orderCancellationChargeType = "order_cancellation_charge_type"
        case orderCancellationChargeValue = "order_cancellation_charge_value"
        case priceRating = "price_rating"
        case providerRate = "provider_rate"
        case providerRateCount = "provider_rate_count"
        case referralCode = "referral_code"
        case referredBy = "referred_by"
        case scheduleOrderCreateAfterMinute = "schedule_order_create_after_minute"
        case serverToken = "server_token"
        case slogan
        case socialIDS = "social_ids"
        case storeDeliveryID = "store_delivery_id"
        case storeRateCount = "store_rate_count"
        case storeTime = "store_time"
        case storeType = "store_type"
        case storeTypeID = "store_type_id"
        case totalReferrals = "total_referrals"
        case uniqueId = "unique_id"
        case updatedAt = "updated_at"
        case userRate = "user_rate"
        case userRateCount = "user_rate_count"
        case wallet
        case walletCurrencyCode = "wallet_currency_code"
        case websiteURL = "website_url"
    }
    
    override init() {
        super.init()
    }
    
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        if let accountID = try container.decodeIfPresent(String.self, forKey: .accountID) {
            self.accountID = accountID
        }
        if let adminProfitModeOnStore = try container.decodeIfPresent(Int.self, forKey: .adminProfitModeOnStore) {
            self.adminProfitModeOnStore = adminProfitModeOnStore
        }
        if let adminProfitValueOnStore = try container.decodeIfPresent(Int.self, forKey: .adminProfitValueOnStore) {
            self.adminProfitValueOnStore = adminProfitValueOnStore
        }
        if let adminType = try container.decodeIfPresent(Int.self, forKey: .adminType) {
            self.adminType = adminType
        }
        if let appVersion = try container.decodeIfPresent(String.self, forKey: .appVersion) {
            self.appVersion = appVersion
        }
        if let bankID = try container.decodeIfPresent(String.self, forKey: .bankID) {
            self.bankID = bankID
        }
        if let cityID = try container.decodeIfPresent(String.self, forKey: .cityID) {
            self.cityID = cityID
        }
        if let comments = try container.decodeIfPresent(String.self, forKey: .comments) {
            self.comments = comments
        }
        if let countryID = try container.decodeIfPresent(String.self, forKey: .countryID) {
            self.countryID = countryID
        }
        if let countryPhoneCode = try container.decodeIfPresent(String.self, forKey: .countryPhoneCode) {
            self.countryPhoneCode = countryPhoneCode
        }
        if let createdAt = try container.decodeIfPresent(String.self, forKey: .createdAt) {
            self.createdAt = createdAt
        }
        if let deviceToken = try container.decodeIfPresent(String.self, forKey: .deviceToken) {
            self.deviceToken = deviceToken
        }
        if let deviceType = try container.decodeIfPresent(String.self, forKey: .deviceType) {
            self.deviceType = deviceType
        }
        if let email = try container.decodeIfPresent(String.self, forKey: .email) {
            self.email = email
        }
        if let famousProductsTags = try container.decodeIfPresent([String].self, forKey: .famousProductsTags) {
            self.famousProductsTags = famousProductsTags
        }
        if let freeDeliveryForAboveOrderPrice = try container.decodeIfPresent(Int.self, forKey: .freeDeliveryForAboveOrderPrice) {
            self.freeDeliveryForAboveOrderPrice = freeDeliveryForAboveOrderPrice
        }
        if let freeDeliveryWithinRadius = try container.decodeIfPresent(Int.self, forKey: .freeDeliveryWithinRadius) {
            self.freeDeliveryWithinRadius = freeDeliveryWithinRadius
        }
        if let informScheduleOrderBeforeMin = try container.decodeIfPresent(Int.self, forKey: .informScheduleOrderBeforeMin) {
            self.informScheduleOrderBeforeMin = informScheduleOrderBeforeMin
        }
        if let isApproved = try container.decodeIfPresent(Bool.self, forKey: .isApproved) {
            self.isApproved = isApproved
        }
        if let isAskEstimatedTimeForReadyOrder = try container.decodeIfPresent(Bool.self, forKey: .isAskEstimatedTimeForReadyOrder) {
            self.isAskEstimatedTimeForReadyOrder = isAskEstimatedTimeForReadyOrder
        }
        if let isBusiness = try container.decodeIfPresent(Bool.self, forKey: .isBusiness) {
            self.isBusiness = isBusiness
        }
        if let isDocumentUploaded = try container.decodeIfPresent(Bool.self, forKey: .isDocumentUploaded) {
            self.isDocumentUploaded = isDocumentUploaded
        }
        if let isEmailVerified = try container.decodeIfPresent(Bool.self, forKey: .isEmailVerified) {
            self.isEmailVerified = isEmailVerified
        }
        if let isOrderCancellationChargeApply = try container.decodeIfPresent(Bool.self, forKey: .isOrderCancellationChargeApply) {
            self.isOrderCancellationChargeApply = isOrderCancellationChargeApply
        }
        if let isPhoneNumberVerified = try container.decodeIfPresent(Bool.self, forKey: .isPhoneNumberVerified) {
            self.isPhoneNumberVerified = isPhoneNumberVerified
        }
        if let isProvideDeliveryAnywhere = try container.decodeIfPresent(Bool.self, forKey: .isProvideDeliveryAnywhere) {
            self.isProvideDeliveryAnywhere = isProvideDeliveryAnywhere
        }
        if let isReferral = try container.decodeIfPresent(Bool.self, forKey: .isReferral) {
            self.isReferral = isReferral
        }
        if let isStoreBusy = try container.decodeIfPresent(Bool.self, forKey: .isStoreBusy) {
            self.isStoreBusy = isStoreBusy
        }
        if let isStorePayDeliveryFees = try container.decodeIfPresent(Bool.self, forKey: .isStorePayDeliveryFees) {
            self.isStorePayDeliveryFees = isStorePayDeliveryFees
        }
        if let isTakingScheduleOrder = try container.decodeIfPresent(Bool.self.self, forKey: .isTakingScheduleOrder) {
            self.isTakingScheduleOrder = isTakingScheduleOrder
        }
        if let isVisible = try container.decodeIfPresent(Bool.self.self, forKey: .isVisible) {
            self.isVisible = isVisible
        }
        if let itemTax = try container.decodeIfPresent(Int.self, forKey: .itemTax) {
            self.itemTax = itemTax
        }
        if let locationLatitude = try container.decodeIfPresent(Double.self, forKey: .locationLatitude) {
            self.locationLatitude = locationLatitude
        }
        if let locationLongitude = try container.decodeIfPresent(Double.self, forKey: .locationLongitude) {
            self.locationLongitude = locationLongitude
        }
        if let loginBy = try container.decodeIfPresent(String.self, forKey: .loginBy) {
            self.loginBy = loginBy
        }
        if let openpayID = try container.decodeIfPresent(String.self, forKey: .openpayID) {
            self.openpayID = openpayID
        }
        if let orderCancellationChargeForAboveOrderPrice = try container.decodeIfPresent(Int.self, forKey: .orderCancellationChargeForAboveOrderPrice) {
            self.orderCancellationChargeForAboveOrderPrice = orderCancellationChargeForAboveOrderPrice
        }
        if let orderCancellationChargeType = try container.decodeIfPresent(Int.self, forKey: .orderCancellationChargeType) {
            self.orderCancellationChargeType = orderCancellationChargeType
        }
        if let orderCancellationChargeValue = try container.decodeIfPresent(Int.self, forKey: .orderCancellationChargeValue) {
            self.orderCancellationChargeValue = orderCancellationChargeValue
        }
        if let providerRate = try container.decodeIfPresent(Int.self, forKey: .providerRate) {
            self.providerRate = providerRate
        }
        if let providerRateCount = try container.decodeIfPresent(Int.self, forKey: .providerRateCount) {
            self.providerRateCount = providerRateCount
        }
        if let referralCode = try container.decodeIfPresent(String.self, forKey: .referralCode) {
            self.referralCode = referralCode
        }
        if let referredBy = try container.decodeIfPresent(String.self, forKey: .referredBy) {
            self.referredBy = referredBy
        }
        if let scheduleOrderCreateAfterMinute = try container.decodeIfPresent(Int.self, forKey: .scheduleOrderCreateAfterMinute) {
            self.scheduleOrderCreateAfterMinute = scheduleOrderCreateAfterMinute
        }
        if let serverToken = try container.decodeIfPresent(String.self, forKey: .serverToken) {
            self.serverToken = serverToken
        }
        if let slogan = try container.decodeIfPresent(String.self, forKey: .slogan) {
            self.slogan = slogan
        }
        if let socialIDS = try container.decodeIfPresent([String].self, forKey: .socialIDS) {
            self.socialIDS = socialIDS
        }
        if let storeRateCount = try container.decodeIfPresent(Int.self, forKey: .storeRateCount) {
            self.storeRateCount = storeRateCount
        }
        if let storeTime = try container.decodeIfPresent([StoreTime].self, forKey: .storeTime) {
            self.storeTime = storeTime
        }
        if let storeType = try container.decodeIfPresent(Int.self, forKey: .storeType) {
            self.storeType = storeType
        }
        if let storeTypeID = try container.decodeIfPresent(String.self, forKey: .storeTypeID) {
            self.storeTypeID = storeTypeID
        }
        if let totalReferrals = try container.decodeIfPresent(Int.self, forKey: .totalReferrals) {
            self.totalReferrals = totalReferrals
        }
        if let uniqueId = try container.decodeIfPresent(Int.self, forKey: .uniqueId) {
            self.uniqueId = uniqueId
        }
        if let updatedAt = try container.decodeIfPresent(String.self, forKey: .updatedAt) {
            self.updatedAt = updatedAt
        }
        if let userRateCount = try container.decodeIfPresent(Int.self, forKey: .userRateCount) {
            self.userRateCount = userRateCount
        }
        if let wallet = try container.decodeIfPresent(Int.self, forKey: .wallet) {
            self.wallet = wallet
        }
    }
    
    init(v: Int?, id: String?, accountID: String?, address: String?, adminProfitModeOnStore: Int?, adminProfitValueOnStore: Int?, adminType: Int?, appVersion: String?, bankID: String?, cityID: String?, comments: String?, countryID: String?, countryPhoneCode: String?, createdAt: String?, deliveryRadius: Int?, deliveryTime: Int?, deliveryTimeMax: Int?, deviceToken: String?, deviceType: String?, email: String?, famousProductsTags: [String]?, freeDeliveryForAboveOrderPrice: Int?, freeDeliveryWithinRadius: Int?, imageURL: String?, informScheduleOrderBeforeMin: Int?, isApproved: Bool?, isAskEstimatedTimeForReadyOrder: Bool?, isBusiness: Bool?, isDocumentUploaded: Bool?, isEmailVerified: Bool?, isOrderCancellationChargeApply: Bool?, isPhoneNumberVerified: Bool?, isProvideDeliveryAnywhere: Bool?, isReferral: Bool?, isStoreBusy: Bool?, isStorePayDeliveryFees: Bool?, isTakingScheduleOrder: Bool?, isVisible: Bool?, itemTax: Int?, location: [Double]?, locationLatitude: Double?, locationLongitude: Double?, loginBy: String?, maxItemQuantityAddByUser: Int?, minOrderPrice: Int?, name: String?, openpayID: String?, orderCancellationChargeForAboveOrderPrice: Int?, orderCancellationChargeType: Int?, orderCancellationChargeValue: Int?, password: String?, phone: String?, priceRating: Int?, providerRate: Int?, providerRateCount: Int?, referralCode: String?, referredBy: String?, scheduleOrderCreateAfterMinute: Int?, serverToken: String?, slogan: String?, socialIDS: [String]?, storeDeliveryID: String?, storeRateCount: Int?, storeTime: [StoreTime]?, storeType: Int?, storeTypeID: String?, totalReferrals: Int?, uniqueId: Int?, updatedAt: String?, userRate: Int?, userRateCount: Int?, wallet: Int?, walletCurrencyCode: String?, websiteURL: String?, distance: Double?, isOpenNow: Bool?) {
        
        super.init(v: v, id: id, address: address, deliveryRadius: deliveryRadius, deliveryTime: deliveryTime, deliveryTimeMax: deliveryTimeMax, distance: distance, imageURL: imageURL, location: location, maxItemQuantityAddByUser: maxItemQuantityAddByUser, minOrderPrice: minOrderPrice, name: name, phone: phone, priceRating: priceRating, storeDeliveryID: storeDeliveryID, userRate: userRate, walletCurrencyCode: walletCurrencyCode, websiteURL: websiteURL, isOpenNow: isOpenNow)
        
        
        self.accountID = accountID
        self.adminProfitModeOnStore = adminProfitModeOnStore
        self.adminProfitValueOnStore = adminProfitValueOnStore
        self.adminType = adminType
        self.appVersion = appVersion
        self.bankID = bankID
        self.cityID = cityID
        self.comments = comments
        self.countryID = countryID
        self.countryPhoneCode = countryPhoneCode
        self.createdAt = createdAt
        self.deviceToken = deviceToken
        self.deviceType = deviceType
        self.email = email
        self.famousProductsTags = famousProductsTags
        self.freeDeliveryForAboveOrderPrice = freeDeliveryForAboveOrderPrice
        self.freeDeliveryWithinRadius = freeDeliveryWithinRadius
        self.informScheduleOrderBeforeMin = informScheduleOrderBeforeMin
        self.isApproved = isApproved
        self.isAskEstimatedTimeForReadyOrder = isAskEstimatedTimeForReadyOrder
        self.isBusiness = isBusiness
        self.isDocumentUploaded = isDocumentUploaded
        self.isEmailVerified = isEmailVerified
        self.isOrderCancellationChargeApply = isOrderCancellationChargeApply
        self.isPhoneNumberVerified = isPhoneNumberVerified
        self.isProvideDeliveryAnywhere = isProvideDeliveryAnywhere
        self.isReferral = isReferral
        self.isStoreBusy = isStoreBusy
        self.isStorePayDeliveryFees = isStorePayDeliveryFees
        self.isTakingScheduleOrder = isTakingScheduleOrder
        self.isVisible = isVisible
        self.itemTax = itemTax
        self.locationLatitude = locationLatitude
        self.locationLongitude = locationLongitude
        self.loginBy = loginBy
        self.openpayID = openpayID
        self.orderCancellationChargeForAboveOrderPrice = orderCancellationChargeForAboveOrderPrice
        self.orderCancellationChargeType = orderCancellationChargeType
        self.orderCancellationChargeValue = orderCancellationChargeValue
        self.password = password
        self.providerRate = providerRate
        self.providerRateCount = providerRateCount
        self.referralCode = referralCode
        self.referredBy = referredBy
        self.scheduleOrderCreateAfterMinute = scheduleOrderCreateAfterMinute
        self.serverToken = serverToken
        self.slogan = slogan
        self.socialIDS = socialIDS
        self.storeRateCount = storeRateCount
        self.storeTime = storeTime
        self.storeType = storeType
        self.storeTypeID = storeTypeID
        self.totalReferrals = totalReferrals
        self.uniqueId = uniqueId
        self.updatedAt = updatedAt
        self.userRateCount = userRateCount
        self.wallet = wallet
    }
    
    func isFavorite() -> Bool {
        for store in Identity.shared.user?.favoriteStores ?? [] {
            if self.id == store.id {
                return true
            }
        }
        return false
    }
}
