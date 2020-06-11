//
//  CartAddress.swift
//  deliApp
//
//  Created by iJPe on 6/27/19.
//  Copyright © 2019 reliae. All rights reserved.
//

import Foundation
import MapKit

// MARK: - CartAddress
class CartAddress: Codable {
    var location: [Double]?
    var userDetails: UserDetail?
    var note, city, address, addressType: String?
    var userType: Int?
    
    var locationCoordinate: CLLocationCoordinate2D {
        get {
            return CLLocationCoordinate2D(latitude: location![0], longitude: location![1])
        }
        set {
            location = [newValue.latitude, newValue.longitude]
        }
    }
    
    private enum CodingKeys: String, CodingKey {
        case location
        case userDetails = "user_details"
        case note, city, address
        case addressType = "address_type"
        case userType = "user_type"
    }
    
    init() {
    }
    
    init(location: [Double]?, userDetails: UserDetail?, note: String?, city: String?, address: String?, addressType: String?, userType: Int?) {
        self.location = location
        self.userDetails = userDetails
        self.note = note
        self.city = city
        self.address = address
        self.addressType = addressType
        self.userType = userType
    }
}
