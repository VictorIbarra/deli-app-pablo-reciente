//
//  ForgetPasswordViewController.swift
//  deliApp
//
//  Created by iJPe on 6/1/19.
//  Copyright © 2019 reliae. All rights reserved.
//

import Foundation
import UIKit
import Presentr
import Device

//MARK: - ForgetPasswordViewController
class ForgetPasswordViewController: JPCustomViewController, UITextFieldDelegate {
    
    static let presentr: Presentr = {
        let customPresentr = Presentr(presentationType: .fullScreen)
        customPresentr.transitionType = .coverVertical
        customPresentr.dismissTransitionType = .crossDissolve
        customPresentr.roundCorners = false
        customPresentr.backgroundColor = .black
        customPresentr.backgroundOpacity = 0.5
        customPresentr.dismissOnSwipe = true
        customPresentr.dismissOnSwipeDirection = .bottom
        return customPresentr
    }()
    
    @IBOutlet var txtEmail: UITextField!
    
    static func present(over viewController: UIViewController) {
        let vc = UIStoryboard(name: "Login", bundle: nil).instantiateViewController(withIdentifier: "forgetPasswordVC")
        presentr.viewControllerForContext = viewController
        viewController.customPresent(viewController: vc, animated: true, presentr: presentr, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.txtEmail.delegate = self
    }
    
    //MARK: UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.closeKeyboard()
        return true
    }
    
    //MARK: Actions
    @IBAction func send(_ sender: Any) {
        
    }
}
