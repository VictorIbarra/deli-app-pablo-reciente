//
//  Errors.swift
//  deliApp
//
//  Created by iJPe on 5/1/19.
//  Copyright © 2019 reliae. All rights reserved.
//

import Foundation

enum CustomError: LocalizedError {
    case validationError(String)
    
    var errorDescription: String? {
        switch self {
        case let .validationError(message):
            return message
        }
    }
}
