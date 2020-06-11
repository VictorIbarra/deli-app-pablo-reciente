//
//  UIView+Extensions.swift
//  deliApp
//
//  Created by iJPe on 06/11/19.
//  Copyright © 2019 reliae. All rights reserved.
//

import UIKit

extension UIView {
    func roundCorners(_ corners:UIRectCorner, radius: CGFloat) {

        let maskLayer = CAShapeLayer()
        maskLayer.frame = self.bounds
        maskLayer.path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius)).cgPath
        self.layer.mask = maskLayer

        let borderLayer = CAShapeLayer()
        borderLayer.path = maskLayer.path
        borderLayer.fillColor = UIColor.clear.cgColor
        borderLayer.strokeColor = self.layer.borderColor
        borderLayer.lineWidth = self.layer.borderWidth
        borderLayer.frame = self.bounds
        self.layer.addSublayer(borderLayer)
    }
    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        get {
            return UIColor(cgColor: layer.borderColor!)
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
}
