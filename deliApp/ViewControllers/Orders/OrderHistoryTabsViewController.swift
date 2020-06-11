//
//  OrderViewController.swift
//  deliApp
//
//  Created by iJPe on 11/1/18.
//  Copyright © 2018 reliae. All rights reserved.
//

import UIKit
import XLPagerTabStrip
import Presentr

class OrderHistoryTabsViewController: ButtonBarPagerTabStripViewController {
    
    var order: Order!
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    
    static let presentr: Presentr = {
        let customPresentr = Presentr(presentationType: .fullScreen)
        customPresentr.transitionType = .coverVertical
        customPresentr.dismissTransitionType = .crossDissolve
        customPresentr.roundCorners = false
        customPresentr.backgroundColor = .black
        customPresentr.backgroundOpacity = 0.5
        customPresentr.dismissOnSwipe = true
        customPresentr.dismissOnSwipeDirection = .bottom
        return customPresentr
    }()
    
    static func present(over viewController: UIViewController, for order: Order) {
        let vc = UIStoryboard(name: "Orders", bundle: nil).instantiateViewController(withIdentifier: "orderHistoryTabsVC") as! OrderHistoryTabsViewController
        vc.order = order
        presentr.viewControllerForContext = viewController
        viewController.customPresent(viewController: vc, animated: true, presentr: presentr, completion: nil)
    }
    
    override func viewDidLoad() {
        self.buttonBarView.collectionViewLayout = UICollectionViewFlowLayout()
        
        self.settings.style.buttonBarBackgroundColor = UIColor.white
        self.settings.style.buttonBarItemBackgroundColor = UIColor.white
        self.settings.style.selectedBarBackgroundColor = UIColor.Deli.primaryRed
        self.settings.style.selectedBarHeight = 2.0
        self.settings.style.buttonBarMinimumLineSpacing = 0
        self.settings.style.buttonBarItemTitleColor = UIColor.white
        
        self.settings.style.buttonBarLeftContentInset = 16
        self.settings.style.buttonBarRightContentInset = 16
        
        changeCurrentIndexProgressive = { (oldCell: ButtonBarViewCell?, newCell: ButtonBarViewCell?, progressPercentage: CGFloat, changeCurrentIndex: Bool, animated: Bool) -> Void in
            guard changeCurrentIndex == true else { return }
            oldCell?.label.textColor = UIColor.Deli.darkGrey
            newCell?.label.textColor = UIColor.Deli.primaryRed
        }
        
        super.viewDidLoad()
        layout()
    }
    
    private func configure() {
        
    }
    
    private func layout() {
        lblTitle.text = "Orden #\(order.uniqueId!)"
        lblDate.text = order.createdAt
    }
    
    //MARK: Functions
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        let sb = UIStoryboard(name: "Orders", bundle: nil)
        
        let vc = sb.instantiateViewController(withIdentifier: "orderHistoryDetailVC") as! OrderHistoryDetailViewController
        vc.order = self.order
        
        let vcTicket = sb.instantiateViewController(withIdentifier: "orderHistoryTicketVC") as! OrderHistoryTicketViewController
        vcTicket.order = self.order
        
        let vcCart = sb.instantiateViewController(withIdentifier: "orderHistoryCartVC") as! OrderHistoryCartViewController
        vcCart.order = self.order
        
        return [vc, vcTicket, vcCart]
    }
}
