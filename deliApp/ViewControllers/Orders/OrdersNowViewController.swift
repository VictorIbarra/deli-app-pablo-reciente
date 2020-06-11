//
//  OrdersNowViewController.swift
//  deliApp
//
//  Created by iJPe on 10/22/18.
//  Copyright © 2018 reliae. All rights reserved.
//

import Foundation
import UIKit
import XLPagerTabStrip
import KVNProgress
import SwiftyJSON
import Alamofire

//MARK: CellOrderNow
class CellOrderNow: UITableViewCell {
    @IBOutlet var imgStore: UIImageView!
    @IBOutlet var lblStoreName: UILabel!
    @IBOutlet var lblPrice: UILabel!
    @IBOutlet var lblOrderNumber: UILabel!
    @IBOutlet var lblStatus: UILabel!
}

//MARK: OrdersNowViewController
class OrdersNowViewController: UIViewController, IndicatorInfoProvider {
    
    var orders: [Order]!
    
    @IBOutlet var tbl: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tbl.dataSource = self
        self.tbl.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.loadOrders()
    }
    
    //MARK: IndicatorInfoProvider
    public func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "Activas")
    }
    
    //MARK: Functions
    private func loadOrders() {
        OrderServices.loadActiveOrders(successHandler: { (orders) in
            self.orders = orders
            self.tbl.reloadData()
        }) { (error) in
            KVNProgress.showError(withStatus: error.localizedDescription)
        }
    }
}

//MARK: UITableViewDataSource
extension OrdersNowViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orders?.count ?? 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if orders?.count ?? 0 > 0 {
            let order = orders[indexPath.row]
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CellOrderNow
            
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
}

extension OrdersNowViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        OrderActiveViewController.open(withId: orders[indexPath.row].id!, on: navigationController!)
    }
}
