//
//  Specification.swift
//  deliApp
//
//  Created by iJPe on 6/5/19.
//  Copyright © 2019 reliae. All rights reserved.
//

import Foundation

// MARK: - SpecificationBase
class SpecificationBase: NSObject, Codable {
    var price: Double = 0.0
    var list: [ItemSpecification] = []
    var type: Int = 1
    var name: String = ""
    var uniqueId: Int = 0
    
    enum CodingKeys: String, CodingKey {
        case uniqueId = "unique_id"
    }
}

// MARK: - Specification
class Specification: SpecificationBase {
    var id: String?
    var isUserSelected: Bool?
    var isDefaultSelected: Bool?
    
    enum CodingKeys: String, CodingKey {
        case id
        case isUserSelected = "is_user_selected"
        case isDefaultSelected = "is_default_selected"
    }
    
    /*init(id: String?, name: String?, list: [String]?, price: Double?, is_user_selected: Bool?, is_default_selected: Bool?, unique_id: Int?, type: Int?) {
        self.id = id
        self.name = name
        self.list = list
        self.unique_id = unique_id
        self.price = price
        self.is_user_selected = is_user_selected
        self.is_default_selected = is_default_selected
        self.type = type
    }*/
}
