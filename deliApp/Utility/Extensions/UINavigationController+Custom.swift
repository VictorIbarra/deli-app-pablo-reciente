//
//  NavigationController+Custom.swift
//  deliApp
//
//  Created by iJPe on 14/10/19.
//  Copyright © 2019 reliae. All rights reserved.
//

import Foundation
import UIKit

extension UINavigationController {
    public func backButtonEmptyText() {
        let backButton = UIBarButtonItem()
        backButton.title = ""
        navigationBar.topItem?.backBarButtonItem = backButton
    }
    
    public func customPrimaryNavigationBar() {
        self.navigationBar.isTranslucent = false
        self.navigationBar.tintColor = UIColor.Deli.secondaryRed
        self.navigationBar.barTintColor = UIColor.white
        self.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.Deli.darkGrey]
        
        let backButton = UIBarButtonItem()
        backButton.title = ""
        self.navigationBar.topItem?.backBarButtonItem = backButton
    }
    
    public func customSecondaryNavigationBar() {
        self.navigationBar.isTranslucent = false
        self.navigationBar.tintColor = UIColor.white
        self.navigationBar.barTintColor = UIColor.black
        self.navigationBar.backgroundColor = UIColor.black
        self.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
        let backButton = UIBarButtonItem()
        backButton.title = ""
        self.navigationBar.topItem?.backBarButtonItem = backButton
    }
    
    public func customTransparentPrimaryNavigationBar(isTranslucent: Bool = true) {
        self.navigationBar.isTranslucent = isTranslucent
        self.navigationBar.tintColor = UIColor.Deli.primaryRed
        self.navigationBar.barTintColor = UIColor.clear
        self.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.Deli.primaryRed]
        
        let backButton = UIBarButtonItem()
        backButton.title = ""
        self.navigationBar.topItem?.backBarButtonItem = backButton
    }
    
    public func customTransparentWhiteNavigationBar(isTranslucent: Bool = true) {
        self.navigationBar.isTranslucent = isTranslucent
        self.navigationBar.tintColor = UIColor.white
        self.navigationBar.barTintColor = UIColor.clear
        self.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
        let backButton = UIBarButtonItem()
        backButton.title = ""
        self.navigationBar.topItem?.backBarButtonItem = backButton
    }
}

extension UIViewController {
    public func setupNavigationTitle(title: String) {
        let view = UILabel()
        view.text = title
        view.textColor = UIColor.black
        view.font.withSize(16)
        
        navigationItem.titleView = view
    }
}
