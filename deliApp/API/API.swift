//
//  API.swift
//  MoviesJP
//
//  Created by iJPe on 2/26/19.
//  Copyright © 2019 jp. All rights reserved.
//

import Foundation

class API {
    static let address: AddressAPI = { return AddressAPI() }()
    static let card: CardAPI = { return CardAPI() }()
    static let user: UserAPI = { return UserAPI() }()
    static let cart: CartAPI = { return CartAPI() }()
    static let order: OrderAPI = { return OrderAPI() }()
    static let store: StoreAPI = { return StoreAPI() }()
    static let ad: AdAPI = { return AdAPI() }()
    static let product: ProductAPI = { return ProductAPI() }()
}
