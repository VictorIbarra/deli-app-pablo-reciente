//
//  ProductsServices.swift
//  deliApp
//
//  Created by iJPe on 11/04/20.
//  Copyright © 2020 reliae. All rights reserved.
//

import Foundation

class ProductServices {
    static func loadProducts(for storeId: String, successHandler: @escaping (([Product]) -> Void), errorHandler: @escaping ((Error) -> Void)) {
        API.product.getProducts(for: storeId) { (productsResponse, error) in
            if let products = productsResponse?.products {
                successHandler(products)
            } else {
                logger.error(error!)
                errorHandler(error!)
            }
        }
    }
    
    static func getItem(for productId: String, successHandler: @escaping ((ProductItem, Product) -> Void), errorHandler: @escaping ((Error) -> Void)) {
        API.product.getItem(for: productId) { (itemResponse, error) in
            if let item = itemResponse?.item {
                successHandler(item, itemResponse!.product!)
            } else {
                logger.error(error!)
                errorHandler(error!)
            }
        }
    }
}
