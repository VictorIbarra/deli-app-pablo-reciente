//
//  OrderHistoryCartViewController.swift
//  deliApp
//
//  Created by iJPe on 06/11/19.
//  Copyright © 2019 reliae. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class OrderHistoryCartViewController: UIViewController {
    var order: Order!
    
    @IBOutlet weak var tbl: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        layout()
    }
    
    //MARK: Functions
    private func configure() {
        tbl.dataSource = self
    }
    
    private func layout() {
        
    }
}

//MARK: - IndicatorInfoProvider
extension OrderHistoryCartViewController: IndicatorInfoProvider {
    public func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "Canasta")
    }
}

//MARK: - IndicatorInfoProvider
extension OrderHistoryCartViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return order.cart?.orderDetails?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return order.cart?.orderDetails?[section].items?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return order.cart?.orderDetails?[section].productName ?? ""
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellOrderDetail") as! CellOrderDetail
        cell.configure(for: (order.cart?.orderDetails?[indexPath.section].items![indexPath.row])!)
        return cell
    }
}

