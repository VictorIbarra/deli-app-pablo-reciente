//
//  UIBarButtonItem+Extensions.swift
//  deliApp
//
//  Created by iJPe on 27/03/20.
//  Copyright © 2020 reliae. All rights reserved.
//

import UIKit

extension UIBarButtonItem {
    static func custom(with title: String, icon: UIImage? = nil) -> UIBarButtonItem {
        let length = CGFloat(title.count)
        let button =  UIButton(type: .custom)
        if let icon = icon {
            button.setImage(icon, for: .normal)
        }
        button.frame = CGRect(x: 0, y: 0, width: 50.0 + (length * 10.0), height: 31)
        button.imageEdgeInsets = UIEdgeInsets(top: -1, left: (length * 8.0), bottom: 1, right: 0)//move image to the right
        let label = UILabel(frame: CGRect(x: 3, y: 5, width: 50.0 + (length * 10), height: 20))
        label.font = label.font.withSize(20)
        label.text = title
        label.textAlignment = .left
        label.textColor = UIColor.Deli.darkGrey
        label.backgroundColor =  .clear
        button.addSubview(label)

        return UIBarButtonItem(customView: button)
    }
}

