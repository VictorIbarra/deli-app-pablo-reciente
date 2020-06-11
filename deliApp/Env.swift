//
//  Env.swift
//  MoviesJP
//
//  Created by iJPe on 2/26/19.
//  Copyright © 2019 jp. All rights reserved.
//

import Foundation

struct Env {
    struct Deli {
        static var token: String {
            return ""
        }
        static var host: String {
            #if DEV
                return "http://localhost:3000/"
            #elseif TEST
                return "https://deli2-backend.deliapp.mx/"
            #elseif PRODUCTION
                return "https://deli2-backend.deliapp.mx/"
            #endif
        }
        static var hostImages: String {
            return "https://deli2-backend-dev.deliapp.mx/"
        }
        static var hostApi: String {
            return "\(host)api/2/"
        }
        static var defaultPaymentId: String {
            return "5b07af95ed9e442a6ed6d061"
        }
    }
    struct Openpay {
        static var merchantId: String {
                return "mwy0ixolw11yjmhsyqzs"
        }
        static var apiKey: String {
            
                return "pk_c975a7f95bbb48a493b5170b057559e6"
        }
        static var production: Bool {
            
                return false
        }
    }
}
