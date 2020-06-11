//
//  DayTime.swift
//  deliApp
//
//  Created by iJPe on 6/27/19.
//  Copyright © 2019 reliae. All rights reserved.
//

import Foundation

// MARK: - DayTime
class DayTime: Codable {
    var storeOpenTime, storeCloseTime: String?
    
    enum CodingKeys: String, CodingKey {
        case storeOpenTime = "store_open_time"
        case storeCloseTime = "store_close_time"
    }
    
    init(storeOpenTime: String?, storeCloseTime: String?) {
        self.storeOpenTime = storeOpenTime
        self.storeCloseTime = storeCloseTime
    }
}
