//
//  SignUpViewController.swift
//  deliApp
//
//  Created by iJPe on 11/1/18.
//  Copyright © 2018 reliae. All rights reserved.
//

import Foundation
import UIKit
import KVNProgress
import Alamofire
import SwiftyJSON
import Presentr
import Device

//MARK: - SignUpViewController
class SignUpViewController: JPCustomViewController, UITextFieldDelegate {
    
    var identityDelegate: IdentityDelegate!
    var fbUser: FBUser!
    
    @IBOutlet var txtCountry: UITextField!
    @IBOutlet var txtCelular: UITextField!
    @IBOutlet var txtFirstName: UITextField!
    @IBOutlet var txtLastName: UITextField!
    @IBOutlet var txtEmail: UITextField!
    @IBOutlet var txtCode: UITextField!
    @IBOutlet var txtPassword: UITextField!
    @IBOutlet var switchTerms: UISwitch!
    
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
    
    static func present(over viewController: UIViewController, identityDelegate: IdentityDelegate, fbUser: FBUser! = nil) {
        let vc = UIStoryboard(name: "Login", bundle: nil).instantiateViewController(withIdentifier: "signupVC") as! SignUpViewController
        vc.identityDelegate = identityDelegate
        
        if let fbUser = fbUser {
            vc.fbUser = fbUser
        }
        
        presentr.viewControllerForContext = viewController
        viewController.customPresent(viewController: vc, animated: true, presentr: presentr, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    //MARK: UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case self.txtCountry:
            self.txtCelular.becomeFirstResponder()
        case self.txtCelular:
            self.txtFirstName.becomeFirstResponder()
        case self.txtFirstName:
            self.txtLastName.becomeFirstResponder()
        case self.txtLastName:
            self.txtEmail.becomeFirstResponder()
        case self.txtEmail:
            self.txtCode.becomeFirstResponder()
        default:
            self.closeKeyboard()
        }
        return true
    }
    
    //MARK: Functions
    private func configure() {
        if fbUser != nil {
            fillFacebookData()
        }
        
        txtCountry.delegate = self
        txtCelular.delegate = self
        txtFirstName.delegate = self
        txtLastName.delegate = self
        txtEmail.delegate = self
        txtCode.delegate = self
        txtPassword.delegate = self
    }
    
    private func fillFacebookData() {
        txtEmail.text = fbUser.email
        txtFirstName.text = fbUser.first_name
        txtLastName.text = fbUser.last_name
    }
    
    func signUp() {
        Location.getAddressFrom(latitude: Location.shared.last.coordinate.latitude, longitude: Location.shared.last.coordinate.longitude) { (loc) in
            
            let user = User(id: nil, address: loc?.address, adminType: nil, appVersion: nil, cartID: nil, city: loc?.city, comments: "", countryID: nil, countryPhoneCode: nil, createdAt: nil, currentOrder: nil, deviceToken: UIDevice.current.identifierForVendor!.uuidString, deviceType: "ios", email: self.txtEmail.text, favouriteStores: [], firstName: self.txtFirstName.text, imageURL: nil, isApproved: nil, isDocumentUploaded: nil, isEmailVerified: true, isPhoneNumberVerified: true, isReferral: nil, isUseWallet: nil, isUserTypeApproved: nil, lastName: self.txtLastName.text, location: [Location.shared.last.coordinate.latitude, Location.shared.last.coordinate.longitude], loginBy: nil, openpayID: nil, password: self.txtPassword.text, phone: self.txtCelular.text, promoCount: nil, providerRate: nil, providerRateCount: nil, referralCode: self.txtCode.text, referredBy: nil, serverToken: nil, socialID: nil, socialIDS: [], storeRate: nil, storeRateCount: nil, stripeID: nil, stripeToken: nil, totalReferrals: nil, uniqueId: nil, updatedAt: nil, userType: nil, userTypeID: nil, wallet: nil, walletCurrencyCode: nil)
            
            if let u = self.fbUser {
                user.socialIDS?.append(u.id!)
            }
            
            self.identityDelegate.signUp(user: user, userHandler: { (user) in
                self.dismiss(animated: true, completion: {
                    SceneDelegate.shared.showMainScreen()
                })
            }) { (error) in
                KVNProgress.showError(withStatus: error.localizedDescription)
            }
        }
    }
    
    override func dismiss() {
        super.dismiss()
        identityDelegate.cancel()
    }
    
    //MARK: Actions
    @IBAction func signUp(_ sender: Any) {
        if (self.txtCountry.text?.count)! <= 0 ||
            (self.txtCelular.text?.count)! <= 0 ||
            (self.txtFirstName.text?.count)! <= 0 ||
            (self.txtEmail.text?.count)! <= 0 {
            
            KVNProgress.showError(withStatus: "Todos los campos son requeridos")
        } else {
            if self.switchTerms.isOn {
                let presentr: Presentr = {
                    let width = ModalSize.full
                    let height = ModalSize.fluid(percentage: 0.30)
                    let center = ModalCenterPosition.customOrigin(origin: CGPoint(x: 0, y: 0))
                    let customType = PresentationType.custom(width: width, height: height, center: center)
                    
                    let customPresentr = Presentr(presentationType: customType)
                    customPresentr.transitionType = .coverVerticalFromTop
                    customPresentr.dismissTransitionType = TransitionType.coverVertical
                    customPresentr.roundCorners = false
                    customPresentr.backgroundColor = .black
                    customPresentr.backgroundOpacity = 0.5
                    customPresentr.dismissOnSwipe = true
                    customPresentr.dismissOnSwipeDirection = .top
                    return customPresentr
                }()
                
                let phone = Phone(country_code: "+52", phone: txtCelular.text)
                UserServices.codeForPhoneVerification(phone: phone, successHandler: { (code) in
                    let vc = UIStoryboard(name: "Login", bundle: nil).instantiateViewController(withIdentifier: "confirmPhoneVC") as! VerificationCodeViewController
                    vc.verificationCodeDelegate = self
                    vc.code = code
                    presentr.viewControllerForContext = self
                    self.customPresentViewController(presentr, viewController: vc, animated: true, completion: nil)
                }) { (error) in
                    KVNProgress.showError(withStatus: error.errorDescription!)
                }
            } else {
                KVNProgress.showError(withStatus: "Es necesario aceptar los terminos y condiciones")
            }
        }
    }
}

extension SignUpViewController: VerificationCodeDelegate {
    func isValidated() {
        signUp()
    }
}
