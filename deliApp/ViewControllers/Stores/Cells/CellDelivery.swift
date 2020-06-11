//
//  CellDelivery.swift
//  deliApp
//
//  Created by iJPe on 26/03/20.
//  Copyright © 2020 reliae. All rights reserved.
//

import UIKit
import SDWebImage

class CellDelivery: UITableViewCell {
    var delivery: Delivery!
    
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    
    func configure(delivery: Delivery) {
        self.delivery = delivery
        layout()
    }
    
    func layout() {
        img?.sd_setImage(with: URL(string: "\(Env.Deli.hostImages)\(delivery.imageUrl ?? "")"))
        icon?.sd_setImage(with: URL(string: "\(Env.Deli.hostImages)\(delivery.iconUrl ?? "")"))
        lblName?.text = delivery.name
    }
}
