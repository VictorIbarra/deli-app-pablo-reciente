//
//  Address.swift
//  deliApp
//
//  Created by iJPe on 11/17/18.
//  Copyright © 2018 reliae. All rights reserved.
//

import MapKit

class Address: Codable {
    var id, address, aptNo, createdAt: String
    var addressDescription: String
    var isDefault: Bool?
    var label: String
    var location: [Double]?
    var uniqueId: Int
    var updatedAt: String
    
    var locationCoordinate: CLLocationCoordinate2D {
        get {
            return CLLocationCoordinate2D(latitude: location![0], longitude: location![1])
        }
        set {
            location = [newValue.latitude, newValue.longitude]
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case address
        case aptNo = "apt_no"
        case createdAt = "created_at"
        case addressDescription = "description"
        case isDefault = "is_default"
        case label, location
        case uniqueId = "unique_id"
        case updatedAt = "updated_at"
    }
    
    init(id: String, address: String, aptNo: String, createdAt: String, addressDescription: String, isDefault: Bool?, label: String, location: [Double]?, uniqueId: Int, updatedAt: String) {
        self.id = id
        self.address = address
        self.aptNo = aptNo
        self.createdAt = createdAt
        self.addressDescription = addressDescription
        self.isDefault = isDefault
        self.label = label
        self.location = location
        self.uniqueId = uniqueId
        self.updatedAt = updatedAt
    }
}
