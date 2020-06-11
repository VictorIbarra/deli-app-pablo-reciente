//
//  OrderHistoryTicketViewController.swift
//  deliApp
//
//  Created by iJPe on 06/11/19.
//  Copyright © 2019 reliae. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class OrderHistoryTicketViewController: UIViewController {
    var order: Order!
    
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var lblDistance: UILabel!
    @IBOutlet weak var lblPaymentMethod: UILabel!
    @IBOutlet weak var lblShippingCost: UILabel!
    @IBOutlet weak var lblShippingTotal: UILabel!
    @IBOutlet weak var lblItemsPrice: UILabel!
    @IBOutlet weak var lblItemsTotal: UILabel!
    @IBOutlet weak var lblDiscount: UILabel!
    @IBOutlet weak var svDiscount: UIStackView!
    @IBOutlet weak var lblDeliCashAmount: UILabel!
    @IBOutlet weak var lblCashAmount: UILabel!
    @IBOutlet weak var lblCardAmount: UILabel!
    @IBOutlet weak var lblTotal: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
    }
    
    //MARK: Functions
    private func layout() {
        
        var time: String = ""
        
        for dt in order.dateTime! {
            if dt.status == 25 {
                time = dt.date!
            }
        }
        
        lblTime.text = "\(order.orderPayment?.totalTime ?? 0)"
        lblDistance.text = "\(order.orderPayment?.totalDistance ?? 0) km"
        lblPaymentMethod.text = order.orderPayment?.paymentID
        lblShippingCost.text = "\(order.orderPayment?.totalDeliveryPrice ?? 0.0)".currencyFormatting()
        lblShippingTotal.text = "\(order.orderPayment?.totalDeliveryPrice ?? 0.0)".currencyFormatting()
        lblItemsPrice.text = "\(order.orderPayment?.totalCartPrice ?? 0.0)".currencyFormatting()
        lblItemsTotal.text = "\(order.orderPayment?.totalOrderPrice ?? 0.0)".currencyFormatting()
        lblDeliCashAmount.text = "\(order.orderPayment?.walletPayment ?? 0.0)".currencyFormatting()
        lblCashAmount.text = "\(order.orderPayment?.cashPayment ?? 0.0)".currencyFormatting()
        lblCardAmount.text = "\(order.orderPayment?.cardPayment ?? 0.0)".currencyFormatting()
        lblTotal.text = "\(order.orderPayment?.total ?? 0.0)".currencyFormatting()
    }
}

//MARK: - IndicatorInfoProvider
extension OrderHistoryTicketViewController: IndicatorInfoProvider {
    public func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "Recibo")
    }
}

