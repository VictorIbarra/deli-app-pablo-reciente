//
//  RedLargeButton.swift
//  deliApp
//
//  Created by iJPe on 12/10/19.
//  Copyright © 2019 reliae. All rights reserved.
//

import UIKit

@IBDesignable
class RedLargeButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    override func prepareForInterfaceBuilder() {
        commonInit()
    }

    private func commonInit() {
        layer.cornerRadius = 8.0
        backgroundColor = UIColor.Deli.primaryRed
        setTitleColor(.white, for: .normal)
    }
}
