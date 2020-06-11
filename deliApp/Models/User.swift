//
//  User.swift
//  deliApp
//
//  Created by iJPe on 6/21/19.
//  Copyright © 2019 reliae. All rights reserved.
//

import Foundation

class User: Codable {
    var id, address: String?
    var adminType: Int?
    var appVersion: String?
    var cartID, city, comments, countryID: String?
    var countryPhoneCode, createdAt: String?
    var currentOrder: String?
    var deviceToken, deviceType, email: String?
    var favoriteStores: [Store] = []
    var favoriteStoresIds: [String]?
    var firstName, imageURL: String?
    var isApproved, isDocumentUploaded, isEmailVerified, isPhoneNumberVerified: Bool?
    var isReferral, isUseWallet, isUserTypeApproved: Bool?
    var lastName: String?
    var location: [Double]?
    var loginBy, openpayID, password, phone: String?
    var promoCount, providerRate, providerRateCount: Int?
    var referralCode: String?
    var referredBy: String?
    var serverToken, socialID: String?
    var socialIDS: [String]?
    var storeRate, storeRateCount: Int?
    var stripeID: String?
    var stripeToken: String?
    var totalReferrals, uniqueId: Int?
    var updatedAt: String?
    var userType: Int?
    var userTypeID: String?
    var wallet: Double?
    var walletCurrencyCode, userID: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case address
        case adminType = "admin_type"
        case appVersion = "app_version"
        case cartID = "cart_id"
        case city, comments
        case countryID = "country_id"
        case countryPhoneCode = "country_phone_code"
        case createdAt = "created_at"
        case currentOrder = "current_order"
        case deviceToken = "device_token"
        case deviceType = "device_type"
        case email
        case favoriteStoresIds = "favourite_stores"
        case firstName = "first_name"
        case imageURL = "image_url"
        case isApproved = "is_approved"
        case isDocumentUploaded = "is_document_uploaded"
        case isEmailVerified = "is_email_verified"
        case isPhoneNumberVerified = "is_phone_number_verified"
        case isReferral = "is_referral"
        case isUseWallet = "is_use_wallet"
        case isUserTypeApproved = "is_user_type_approved"
        case lastName = "last_name"
        case location
        case loginBy = "login_by"
        case openpayID = "openpay_id"
        case password, phone
        case promoCount = "promo_count"
        case providerRate = "provider_rate"
        case providerRateCount = "provider_rate_count"
        case referralCode = "referral_code"
        case referredBy = "referred_by"
        case serverToken = "server_token"
        case socialID = "social_id"
        case socialIDS = "social_ids"
        case storeRate = "store_rate"
        case storeRateCount = "store_rate_count"
        case stripeID = "stripe_id"
        case stripeToken = "stripe_token"
        case totalReferrals = "total_referrals"
        case uniqueId = "unique_id"
        case updatedAt = "updated_at"
        case userType = "user_type"
        case userTypeID = "user_type_id"
        case wallet
        case walletCurrencyCode = "wallet_currency_code"
    }
    
    init() {
    }
    
    init(id: String?, address: String?, adminType: Int?, appVersion: String?, cartID: String?, city: String?, comments: String?, countryID: String?, countryPhoneCode: String?, createdAt: String?, currentOrder: String?, deviceToken: String?, deviceType: String?, email: String?, favouriteStores: [String]?, firstName: String?, imageURL: String?, isApproved: Bool?, isDocumentUploaded: Bool?, isEmailVerified: Bool?, isPhoneNumberVerified: Bool?, isReferral: Bool?, isUseWallet: Bool?, isUserTypeApproved: Bool?, lastName: String?, location: [Double]?, loginBy: String?, openpayID: String?, password: String?, phone: String?, promoCount: Int?, providerRate: Int?, providerRateCount: Int?, referralCode: String?, referredBy: String?, serverToken: String?, socialID: String?, socialIDS: [String]?, storeRate: Int?, storeRateCount: Int?, stripeID: String?, stripeToken: String?, totalReferrals: Int?, uniqueId: Int?, updatedAt: String?, userType: Int?, userTypeID: String?, wallet: Double?, walletCurrencyCode: String?) {
        self.id = id
        self.address = address
        self.adminType = adminType
        self.appVersion = appVersion
        self.cartID = cartID
        self.city = city
        self.comments = comments
        self.countryID = countryID
        self.countryPhoneCode = countryPhoneCode
        self.createdAt = createdAt
        self.currentOrder = currentOrder
        self.deviceToken = deviceToken
        self.deviceType = deviceType
        self.email = email
        self.favoriteStoresIds = favouriteStores
        self.firstName = firstName
        self.imageURL = imageURL
        self.isApproved = isApproved
        self.isDocumentUploaded = isDocumentUploaded
        self.isEmailVerified = isEmailVerified
        self.isPhoneNumberVerified = isPhoneNumberVerified
        self.isReferral = isReferral
        self.isUseWallet = isUseWallet
        self.isUserTypeApproved = isUserTypeApproved
        self.lastName = lastName
        self.location = location
        self.loginBy = loginBy
        self.openpayID = openpayID
        self.password = password
        self.phone = phone
        self.promoCount = promoCount
        self.providerRate = providerRate
        self.providerRateCount = providerRateCount
        self.referralCode = referralCode
        self.referredBy = referredBy
        self.serverToken = serverToken
        self.socialID = socialID
        self.socialIDS = socialIDS
        self.storeRate = storeRate
        self.storeRateCount = storeRateCount
        self.stripeID = stripeID
        self.stripeToken = stripeToken
        self.totalReferrals = totalReferrals
        self.uniqueId = uniqueId
        self.updatedAt = updatedAt
        self.userType = userType
        self.userTypeID = userTypeID
        self.wallet = wallet
        self.walletCurrencyCode = walletCurrencyCode
    }
    
    func fullName() -> String {
        return "\(firstName ?? "") \(lastName ?? "")"
    }
}
