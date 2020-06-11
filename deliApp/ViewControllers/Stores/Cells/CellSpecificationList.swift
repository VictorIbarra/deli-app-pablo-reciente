//
//  CellSpecification.swift
//  deliApp
//
//  Created by iJPe on 13/04/20.
//  Copyright © 2020 reliae. All rights reserved.
//

import UIKit
import M13Checkbox

class CellSpecificationList: UITableViewCell {
    var specification: ProductSpecification!
    var list: ProductList!
    var specificationDelegate: CellSpecificationListDelegate!
    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var checkbox: M13Checkbox!
    
    func configure(specification: ProductSpecification, list: ProductList, delegate: CellSpecificationListDelegate) {
        self.specification = specification
        self.list = list
        self.specificationDelegate = delegate
        layout()
    }
    
    func layout() {
        checkbox.setMarkType(markType: .checkmark, animated: false)
        checkbox.tintColor = UIColor.Deli.primaryRed
        checkbox.secondaryTintColor = UIColor.Deli.darkGrey
        checkbox.secondaryCheckmarkTintColor = UIColor.white
        checkbox.checkmarkLineWidth = 2.0
        checkbox.boxLineWidth = 0.25
        checkbox.animationDuration = 0.5
        if specification.type == 1 {
            checkbox.stateChangeAnimation = .fill
            checkbox.boxType = .circle
        } else {
            checkbox.stateChangeAnimation = .spiral
            checkbox.boxType = .square
        }
        checkbox.setCheckState(list.isSelected ? M13Checkbox.CheckState.checked : M13Checkbox.CheckState.unchecked, animated: false)
        checkbox.addTarget(self, action: #selector(checkBoxValueChanged(_ :)), for: .valueChanged)
        
        lblName.text = list.name
        let price = String.init(describing: list.price!).currencyFormatting()
        lblPrice.text = "+\(price)"
    }
    
    @IBAction func checkBoxValueChanged(_ sender: M13Checkbox) {
        if !(specification.type == 1 && checkbox.checkState == .unchecked) {
            let selected = checkbox.checkState == .checked
            specificationDelegate.tapped(specification: specification, list: list, selected: selected)
        } else {
            checkbox.toggleCheckState(true)
        }
    }
}
