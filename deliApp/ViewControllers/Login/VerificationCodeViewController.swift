//
//  SignUpCodeViewController.swift
//  deliApp
//
//  Created by iJPe on 6/1/19.
//  Copyright © 2019 reliae. All rights reserved.
//

import Foundation
import UIKit
import KVNProgress

//MARK: - VerificationCodeDelegate
protocol VerificationCodeDelegate {
    func isValidated()
}

//MARK: - VerificationCodeViewController
class VerificationCodeViewController: UIViewController {
    var verificationCodeDelegate: VerificationCodeDelegate!
    var code: String!
    
    @IBOutlet var txtCode: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        #if !PRODUCTION
        txtCode.text = code
        #endif
    }
    
    //MARK: Functions
    private func validate() {
        if txtCode.text == code {
            verificationCodeDelegate.isValidated()
        } else {
            KVNProgress.showError(withStatus: "Invalid code")
        }
    }
    
    //MARK: Actions
    @IBAction func btnSendPressed(_ sender: Any) {
        validate()
    }
}
