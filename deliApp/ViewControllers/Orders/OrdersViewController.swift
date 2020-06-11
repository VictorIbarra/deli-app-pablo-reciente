//
//  OrdersViewController.swift
//  deliApp
//
//  Created by iJPe on 10/22/18.
//  Copyright © 2018 reliae. All rights reserved.
//

import Foundation
import UIKit
import XLPagerTabStrip

//MARK: - OrdersViewController
class OrdersViewController: ButtonBarPagerTabStripViewController {
    
    override func viewDidLoad() {
        self.buttonBarView.collectionViewLayout = UICollectionViewFlowLayout()
        
        self.settings.style.buttonBarBackgroundColor = UIColor.white
        self.settings.style.buttonBarItemBackgroundColor = UIColor.white
        self.settings.style.selectedBarBackgroundColor = UIColor.Deli.primaryRed
        self.settings.style.selectedBarHeight = 2.0
        self.settings.style.buttonBarMinimumLineSpacing = 0
        self.settings.style.buttonBarItemTitleColor = UIColor.white
        
        self.settings.style.buttonBarLeftContentInset = 10
        self.settings.style.buttonBarRightContentInset = 10
        
        changeCurrentIndexProgressive = { (oldCell: ButtonBarViewCell?, newCell: ButtonBarViewCell?, progressPercentage: CGFloat, changeCurrentIndex: Bool, animated: Bool) -> Void in
            guard changeCurrentIndex == true else { return }
            oldCell?.label.textColor = UIColor.Deli.secondaryRed
            newCell?.label.textColor = UIColor.Deli.primaryRed
        }
        
        super.viewDidLoad()
    }
    
    //MARK: PagerTabStripDataSource
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        
        let storyboard = UIStoryboard(name: "Orders", bundle: Bundle.main)
        
        let now = storyboard.instantiateViewController(withIdentifier: "ordersNowVC") as! OrdersNowViewController
        let history = storyboard.instantiateViewController(withIdentifier: "ordersHistoryVC") as! OrdersHistoryViewController
        
        return [now, history]
    }
}
