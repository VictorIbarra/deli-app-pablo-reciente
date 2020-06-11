//
//  CellCategoryProduct.swift
//  deliApp
//
//  Created by iJPe on 13/04/20.
//  Copyright © 2020 reliae. All rights reserved.
//

import UIKit

class CellProductItem: UITableViewCell {
    var item: ProductItem!
    
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    
    func configure(item: ProductItem) {
        self.item = item
        layout()
    }
    
    private func layout() {
        lblName.text = item.name!.trunc(length: 35, trailing: "...")
        lblDescription.text = item.details!.trunc(length: 100, trailing: "...")
        lblPrice.text =  String(describing: item.price!).currencyFormatting()
        
        var url = "http://deliapp.mx/wp-content/uploads/2018/07/f1.jpg"
        if let image = item.imageURL, image.count > 0 {
            url = "\(Env.Deli.hostImages)\(image[0])"
        }
        
        img.sd_setImage(with: URL(string: url))
    }
}
