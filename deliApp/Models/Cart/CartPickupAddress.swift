//
//  CartPickupAddress.swift
//  deliApp
//
//  Created by iJPe on 10/7/19.
//  Copyright © 2019 reliae. All rights reserved.
//

import Foundation

// MARK: - CartPickupAddress
class CartPickupAddress: CartAddress {
    var deliveryStatus: Int?
    
    private enum CodingKeys: String, CodingKey {
        case deliveryStatus = "delivery_status"
    }
    
    override init() {
        super.init()
    }
    
    init(location: [Double]?, userDetails: UserDetail?, note: String?, city: String?, address: String?, addressType: String?, userType: Int?, deliveryStatus: Int?) {
        super.init(location: location, userDetails: userDetails, note: note, city: city, address: address, addressType: addressType, userType: userType)
        self.deliveryStatus = deliveryStatus
    }
    
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        if let deliveryStatus = try container.decodeIfPresent(Int.self, forKey: .deliveryStatus) {
            self.deliveryStatus = deliveryStatus
        }
    }
}

