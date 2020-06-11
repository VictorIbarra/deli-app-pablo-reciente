//
//  OrderHistoryDetailViewController.swift
//  deliApp
//
//  Created by iJPe on 05/11/19.
//  Copyright © 2019 reliae. All rights reserved.
//

import UIKit
import XLPagerTabStrip


class OrderHistoryDetailViewController: UIViewController {
    var order: Order!
    
    @IBOutlet weak var imgStore: UIImageView!
    @IBOutlet weak var lblStoreName: UILabel!
    @IBOutlet weak var lblReceivedBy: UILabel!
    @IBOutlet weak var imgUser: UIImageView!
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var lblAddressFrom: UILabel!
    @IBOutlet weak var lblAddressTo: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var lblDistance: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
    }
    
    //MARK: Functions
    private func layout() {
        imgStore.sd_setImage(with: URL(string: "\(Env.Deli.hostImages)\(order.store?.imageURL! ?? "")"))
        lblStoreName.text = order.store?.name!
        lblReceivedBy.text = "Received"
        imgUser.sd_setImage(with: URL(string: "\(Env.Deli.hostImages)\(Identity.shared.user?.imageURL! ?? "")"))
        lblUserName.text = "\(Identity.shared.user?.firstName! ?? "") \(Identity.shared.user?.lastName! ?? "")"
    }
}

//MARK: - IndicatorInfoProvider
extension OrderHistoryDetailViewController: IndicatorInfoProvider {
    public func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "Detalle")
    }
}
