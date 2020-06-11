//
//  Delivery.swift
//  deliApp
//
//  Created by iJPe on 26/03/20.
//  Copyright © 2020 reliae. All rights reserved.
//

class Delivery: Codable {
    var id: String?
    var name: String?
    var iconUrl: String?
    var imageUrl: String?
    var stores: [Store]?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case iconUrl = "icon_url"
        case imageUrl = "image_url"
        case stores
    }
    
    init(id: String?, name: String?, iconUrl: String?, imageUrl: String?, stores: [Store]?) {
        self.id = id
        self.name = name
        self.iconUrl = iconUrl
        self.imageUrl = imageUrl
        self.stores = stores
    }
}
