//
//  String+Extensions.swift
//  deliApp
//
//  Created by iJPe on 13/03/20.
//  Copyright © 2020 reliae. All rights reserved.
//

import Foundation

extension String {
    func currencyFormatting() -> String {
        if let value = Double(self) {
            let formatter = NumberFormatter()
            formatter.numberStyle = .currency
            formatter.maximumFractionDigits = 2
            if let str = formatter.string(for: value) {
                return str
            }
        }
        return ""
    }
    
    func trunc(length: Int, trailing: String = "…") -> String {
        if (self.count <= length) {
            return self
        }
        var truncated = self.prefix(length)
        while truncated.last != " " {
            truncated = truncated.dropLast()
        }
        return truncated + trailing
    }
}
