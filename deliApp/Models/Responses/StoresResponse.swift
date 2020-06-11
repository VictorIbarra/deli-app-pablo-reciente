//
//  StoresResponse.swift
//  deliApp
//
//  Created by iJPe on 7/18/19.
//  Copyright © 2019 reliae. All rights reserved.
//

import Foundation

// MARK: - StoresResponse
class StoresResponse: Codable {
    let success: Int?
    let stores: [Store]?
    let message: String?
    
    init(success: Int?, stores: [Store]?, message: String?) {
        self.success = success
        self.stores = stores
        self.message = message
    }
}


