//
//  Ad.swift
//  deliApp
//
//  Created by iJPe on 29/03/20.
//  Copyright © 2020 reliae. All rights reserved.
//

class Ad: Codable {
    var id: String?
    var adsType: Int?
    var adsFor: Int?
    var cityId: String?
    var imageUrl: String?
    var imageForMobile: String?
    var imageForBanner: String?
    var isAdsRedirectToStore: Bool?
    var storeId: String?
    var isAdsHaveExpiryDate: Bool?
    var adsDetail: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case adsType = "ads_type"
        case adsFor = "ads_for"
        case cityId = "city_id"
        case imageUrl = "image_url"
        case imageForMobile = "image_for_mobile"
        case imageForBanner = "image_for_banner"
        case isAdsRedirectToStore = "is_ads_redirect_to_store"
        case storeId = "store_id"
        case isAdsHaveExpiryDate = "is_ads_have_expiry_date"
        case adsDetail = "ads_detail"
    }
    
    init(id: String?, adsType: Int?, adsFor: Int?, cityId: String?, imageUrl: String?, imageForMobile: String?, imageForBanner: String?, isAdsRedirectToStore: Bool?, storeId: String?, isAdsHaveExpiryDate: Bool?, adsDetail: String?) {
        self.id = id
        self.adsType = adsType
        self.adsFor = adsFor
        self.cityId = cityId
        self.imageUrl = imageUrl
        self.imageForMobile = imageForMobile
        self.imageForBanner = imageForBanner
        self.isAdsRedirectToStore = isAdsRedirectToStore
        self.storeId = storeId
        self.isAdsHaveExpiryDate = isAdsHaveExpiryDate
        self.adsDetail = adsDetail
    }
}
