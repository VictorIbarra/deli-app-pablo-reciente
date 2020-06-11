//
//  ConfirmPhoneResponse.swift
//  deliApp
//
//  Created by iJPe on 29/10/19.
//  Copyright © 2019 reliae. All rights reserved.
//

import Foundation

class ConfirmPhoneResponse: Codable {
    let success: Int?
    let code: String?
    let message: String?
    
    init(success: Int?, code: String?, message: String?) {
        self.success = success
        self.code = code
        self.message = message
    }
}
