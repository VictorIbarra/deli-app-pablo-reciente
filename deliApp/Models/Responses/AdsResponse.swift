//
//  AdsResponse.swift
//  deliApp
//
//  Created by iJPe on 29/03/20.
//  Copyright © 2020 reliae. All rights reserved.
//

class AdsResponse: Codable {
    var success: Int?
    var advertises: [Ad]?
    var message: String?
    
    init(success: Int?, advertises: [Ad]?, message: String?) {
        self.success = success
        self.advertises = advertises
        self.message = message
    }
}
