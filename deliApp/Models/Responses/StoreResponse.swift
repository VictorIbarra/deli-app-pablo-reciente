//
//  StoreResponse.swift
//  deliApp
//
//  Created by iJPe on 8/19/19.
//  Copyright © 2019 reliae. All rights reserved.
//

import Foundation

// MARK: - StoresResponse
class StoreResponse: Codable {
    let success: Int?
    let store: Store?
    let message: String?
    
    init(success: Int?, store: Store?, message: String?) {
        self.success = success
        self.store = store
        self.message = message
    }
}
