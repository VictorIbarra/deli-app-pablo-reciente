//
//  ItemSpecification.swift
//  deliApp
//
//  Created by iJPe on 6/27/19.
//  Copyright © 2019 reliae. All rights reserved.
//

import Foundation

class ItemSpecification: NSObject, Codable {
    var isDefaultSelected: Bool = true
    var uniqueId: Int = 0
    var id: String = ""
    var price: Double = 0.0
    var name: String = ""
    var isUserSelected: Bool = false
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case isDefaultSelected = "is_default_selected"
        case isUserSelected = "is_user_selected"
        case uniqueId = "unique_id"
    }
}
