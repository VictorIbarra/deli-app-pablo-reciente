//
//  OrderViewController.swift
//  deliApp
//
//  Created by iJPe on 11/1/18.
//  Copyright © 2018 reliae. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class OrderHistoryTabsViewController: ButtonBarPagerTabStripViewController {
    
    var order: Order!
    
    override func viewDidLoad() {
        self.buttonBarView.collectionViewLayout = UICollectionViewFlowLayout()
        
        self.settings.style.buttonBarBackgroundColor = UIColor.white
        self.settings.style.buttonBarItemBackgroundColor = UIColor.white
        self.settings.style.selectedBarBackgroundColor = UIColor.Deli.primaryRed
        self.settings.style.selectedBarHeight = 5.0
        self.settings.style.buttonBarMinimumLineSpacing = 0
        self.settings.style.buttonBarItemTitleColor = UIColor.white
        
        self.settings.style.buttonBarLeftContentInset = 30
        self.settings.style.buttonBarRightContentInset = 30
        
        changeCurrentIndexProgressive = { (oldCell: ButtonBarViewCell?, newCell: ButtonBarViewCell?, progressPercentage: CGFloat, changeCurrentIndex: Bool, animated: Bool) -> Void in
            guard changeCurrentIndex == true else { return }
            oldCell?.label.textColor = UIColor.Deli.darkGrey
            newCell?.label.textColor = UIColor.Deli.primaryRed
        }
        
        super.viewDidLoad()
    }
    
    static func present(over viewController: UIViewController, for order: Order) {
        let vc = UIStoryboard(name: "Orders", bundle: nil).instantiateViewController(withIdentifier: "orderHistoryVC") as! OrderHistoryTabsViewController
        vc.order = order
        viewController.customPresentViewController(presentr, viewController: vc, animated: true, completion: nil)
    }
}

//MARK: - PagerTabStripDataSource
extension OrderHistoryTabsViewController: PagerTabStripDataSource {
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        
        let vc = UIStoryboard(name: "Orders", bundle: nil).instantiateViewController(withIdentifier: "orderHistoryDetailVC") as! OrderHistoryDetailViewController
        
        return [vc]
    }
}
