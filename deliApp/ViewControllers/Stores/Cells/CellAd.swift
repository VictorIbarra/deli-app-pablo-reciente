//
//  CellAd.swift
//  deliApp
//
//  Created by iJPe on 29/03/20.
//  Copyright © 2020 reliae. All rights reserved.
//

import UIKit
import SDWebImage

class CellAd: UICollectionViewCell {
    var ad: Ad!
    
    @IBOutlet weak var img: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
//        commonInit()
    }
    
//    func commonInit() {
//        img.frame = self.frame
//    }
    
    func configure(ad: Ad) {
        self.ad = ad
        layout()
    }
    
    func layout() {
        img?.sd_setImage(with: URL(string: "\(Env.Deli.hostImages)\(ad.imageUrl ?? "")"))
    }
}
