//
//  OrdersHistoryViewController.swift
//  deliApp
//
//  Created by iJPe on 10/22/18.
//  Copyright © 2018 reliae. All rights reserved.
//

import Foundation
import UIKit
import XLPagerTabStrip
import Alamofire
import KVNProgress
import SwiftyJSON

class CellOrderHistory: UITableViewCell {
    @IBOutlet weak var imgStore: UIImageView!
    @IBOutlet var lblStoreName: UILabel!
    @IBOutlet var lblPrice: UILabel!
    @IBOutlet var lblOrderNumber: UILabel!
    @IBOutlet var lblStatus: UILabel!
}

class OrdersHistoryViewController: UIViewController, IndicatorInfoProvider, UITableViewDataSource {
    
    var orders: [Order] = []
    
    @IBOutlet var tbl: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        loadHistory()
    }
    
    
    
    //MARK: IndicatorInfoProvider
    public func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "Historial")
    }
    
    //MARK: UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orders.count > 0 ? orders.count : 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if orders.count > 0 {
            let order = orders[indexPath.row]
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CellOrderHistory
            
            cell.imgStore.sd_setImage(with: URL(string: "\(Env.Deli.hostImages)\(order.store?.imageURL! ?? "")"))
            cell.lblStoreName.text = order.store?.name
            cell.lblPrice.text =  "\(order.orderPayment?.currencyCode! ?? "") \(order.orderPayment?.total! ?? 0)"
            cell.lblOrderNumber.text = "\(order.uniqueId!)"
            cell.lblStatus.text = "\(order.orderStatus!)"
            
            cell.tag = indexPath.row
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cellNothing", for: indexPath)
            return cell
        }
    }
    
    //MARK: Functions
    private func configure() {
        tbl.dataSource = self
        tbl.delegate = self
    }
    
    private func loadHistory() {
        OrderServices.loadHistoricalOrders(successHandler: { (orders) in
            self.orders = orders
            self.tbl.reloadData()
        }) { (error) in
            KVNProgress.showError(withStatus: error.localizedDescription)
        }
    }
}

//MARK: - UITableViewDelegate
extension OrdersHistoryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let order = orders[indexPath.row]
        
        OrderServices.loadOrder(id: order.id!, successHandler: { (order) in
            OrderHistoryTabsViewController.present(over: self, for: order)
        }) { (error) in
            KVNProgress.showError(withStatus: error.localizedDescription)
        }
    }
}
