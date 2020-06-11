//
//  StoreCategoryViewController.swift
//  deliApp
//
//  Created by iJPe on 10/26/18.
//  Copyright © 2018 reliae. All rights reserved.
//

import Foundation
import UIKit
import XLPagerTabStrip
import SwiftyJSON
import Presentr
import SkeletonView

//MARK: - StoreProductViewController
class StoreProductViewController: UIViewController, IndicatorInfoProvider {
    
    private var product: Product!
    let presentr: Presentr = {
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
    
    @IBOutlet var tbl: UITableView!
    
    static func configure(forProduct product: Product) -> StoreProductViewController {
        let categoryVC = UIStoryboard(name: "Stores", bundle: nil).instantiateViewController(withIdentifier: "storeCategoryVC") as! StoreProductViewController
        categoryVC.product = product
        
        return categoryVC
    }
    
    static func push(forStore store: Store, product: Product, after viewController: UIViewController) {
        let vc = UIStoryboard(name: "Stores", bundle: nil).instantiateViewController(withIdentifier: "storeCategoryVC") as! StoreProductViewController
        vc.product = product
        
        viewController.navigationController?.pushViewController(vc, animated: true)
    }
    
    override func viewDidLayoutSubviews() {
        view.layoutSkeletonIfNeeded()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        if product == nil {
            layout()
        }
    }
    
    private func configure() {
        tbl.dataSource = self
        tbl.delegate = self
    }
    
    private func layout() {
        tbl.showAnimatedSkeleton()
    }
    
    //MARK: IndicatorInfoProvider
    public func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: product?.name ?? "")
    }
}

//MARK: - SkeletonTableViewDataSource
extension StoreProductViewController: SkeletonTableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let i = product?.items {
            return i.count + 1
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row < product.items?.count ?? 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CellProductItem
            let productItem = product.items![indexPath.row]
            cell.configure(item: productItem)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cellEmpty", for: indexPath)
            return cell
        }
    }
    
    //MARK: Skeleton
    func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return "cell"
    }
}

//MARK: - UITableViewDelegate
extension StoreProductViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row < product.items!.count {
            StoreItemViewController.present(itemId: product.items![indexPath.row].id!, over: self)
        }
    }
}
