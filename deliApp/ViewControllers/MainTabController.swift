//
//  MainTabController.swift
//  deliApp
//
//  Created by iJPe on 11/22/18.
//  Copyright © 2018 reliae. All rights reserved.
//

import Foundation
import UIKit
import CoreData
import Alamofire
import SwiftyJSON

class MainTabController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadCart()
        loadAddress()
        loadPaymentMethods()
        loadFavoriteStores()
    }
    
    //MARK: Functions
    private func loadAddress() {
        AddressServices.loadAddresses()
    }
    
    private func loadPaymentMethods() {
        CardServices.loadCards(successHandler: { (cards) in
        }) { (error) in
            logger.error(error)
        }
    }
    
    private func loadCart() {
        CartServices.load(successHandler: { (cart) in
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "cartLoaded"), object: self, userInfo: nil)
            logger.info("Cart loaded on Home")
        }) { (error) in
            logger.error(error)
        }
    }
    
    private func loadFavoriteStores() {
        StoreServices.getFavoriteStores()
    }
    
    //MARK: Actions
    @IBAction func unwindToHome(segue:UIStoryboardSegue!) {
        
    }
}
