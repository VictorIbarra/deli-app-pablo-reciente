//
//  CellOrderDetail.swift
//  deliApp
//
//  Created by iJPe on 08/11/19.
//  Copyright © 2019 reliae. All rights reserved.
//

import UIKit

class CellOrderDetail: UITableViewCell {
    @IBOutlet var lblName: UILabel!
    @IBOutlet var lblQuantity: UILabel!
    @IBOutlet var lblPrice: UILabel!
    
    public func configure(for item: Item) {
        lblName.text = item.itemName
        lblQuantity.text = "\(item.quantity!)"
        lblPrice.text = "\(item.itemPrice!)".currencyFormatting()
    }
}

