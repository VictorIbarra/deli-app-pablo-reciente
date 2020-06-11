//
//  LoginViewController.swift
//  deliApp
//
//  Created by iJPe on 11/1/18.
//  Copyright © 2018 reliae. All rights reserved.
//

import Foundation
import UIKit
import KVNProgress
import Device

//MARK: - LoginViewController
class LoginViewController: JPCustomViewController, UITextFieldDelegate {
    
    @IBOutlet var txtCelular: UITextField!
    @IBOutlet var txtPassword: UITextField!
    
    var identityDelegate: IdentityDelegate!
    
    override var isViewLoaded: Bool {
        navigationController?.customTransparentPrimaryNavigationBar()
        return super.isViewLoaded
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.txtCelular.delegate = self
        self.txtPassword.delegate = self
    }
    
    //MARK: UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        switch textField {
        case self.txtCelular:
            self.txtPassword.becomeFirstResponder()
        default:
            self.closeKeyboard()
        }
        
        return true
    }
    
    //MARK: Functions
    private func forgetPassword() {
        ForgetPasswordViewController.present(over: self)
    }
    
    private func login() {
        if (self.txtCelular.text?.count)! <= 0 || (self.txtPassword.text?.count)! <= 0 {
            KVNProgress.showError(withStatus: "Todos los campos son requeridos")
        } else {
            identityDelegate.login(user: txtCelular.text!, password: txtPassword.text!, socialId: nil, userHandler: { (user) in
                SceneDelegate.shared.showMainScreen()
            }) { (error) in
                KVNProgress.showError(withStatus: error.localizedDescription)
            }
        }
    }
    
    //MARK: Actions
    @IBAction func btnSignUpPressed(_ sender: Any) {
        SignUpViewController.present(over: self, identityDelegate: self.identityDelegate)
    }
    
    @IBAction func login(_ sender: Any) {
        login()
    }
    
    @IBAction func btnForgetPasswordPressed(_ sender: Any) {
        self.forgetPassword()
    }
}
