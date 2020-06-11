//
//  SuccessResponse.swift
//  deliApp
//
//  Created by iJPe on 6/1/19.
//  Copyright © 2019 reliae. All rights reserved.
//

import Foundation

class SuccessResponse: Codable {
    var success: Int?
    var message: String?
    
    init(success: Int?, message: String?) {
        self.success = success
        self.message = message
    }
}
