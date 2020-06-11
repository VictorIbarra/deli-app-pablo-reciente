//
//  DateTime.swift
//  deliApp
//
//  Created by iJPe on 7/30/19.
//  Copyright © 2019 reliae. All rights reserved.
//

import Foundation

// MARK: - DateTime
class DateTime: Codable {
    let status: Int?
    let date: String?
    
    init(status: Int?, date: String?) {
        self.status = status
        self.date = date
    }
}
