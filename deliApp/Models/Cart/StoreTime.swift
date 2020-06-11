//
//  StoreTime.swift
//  deliApp
//
//  Created by iJPe on 6/27/19.
//  Copyright © 2019 reliae. All rights reserved.
//

import Foundation

// MARK: - StoreTime
class StoreTime: Codable {
    var isStoreOpenFullTime, isStoreOpen: Bool?
    var dayTime: [DayTime]?
    var day: Int?
    
    enum CodingKeys: String, CodingKey {
        case isStoreOpenFullTime = "is_store_open_full_time"
        case isStoreOpen = "is_store_open"
        case dayTime = "day_time"
        case day
    }
    
    init(isStoreOpenFullTime: Bool?, isStoreOpen: Bool?, dayTime: [DayTime]?, day: Int?) {
        self.isStoreOpenFullTime = isStoreOpenFullTime
        self.isStoreOpen = isStoreOpen
        self.dayTime = dayTime
        self.day = day
    }
}
