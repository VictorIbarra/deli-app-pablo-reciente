//
//  RootViewController.swift
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
import FBSDKLoginKit
import Presentr

//MARK: - IdentityDelegate
protocol IdentityDelegate {
    func cancel()
    func signUp(user: User, userHandler: @escaping ((User) -> Void), errorHandler: @escaping ((Error) -> Void))
    func login(user: String, password: String, socialId: String?, userHandler: @escaping ((User) -> Void), errorHandler: @escaping ((Error) -> Void))
}

//MARK: - RootViewController
class RootViewController: JPCustomViewController {
    
    @IBOutlet var loginButton: FBLoginButton!
    @IBOutlet var lblVersion: UILabel!
    
    let presentr: Presentr = {
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
    
    static func login(user: String, password: String, socialId: String) {
        Identity.login(user: user, password: password, socialId: socialId, userHandler: { (user) in
            SceneDelegate.shared.showMainScreen()
        }) { (error) in
            SceneDelegate.shared.showRoot()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        if segue.identifier == "go_to_login" {
            let vc = segue.destination as! LoginViewController
            vc.identityDelegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.loginButton.delegate = self
        self.lblVersion.text = UIApplication.versionBuild()
//        self.loginButton.readPermissions = ["publicProfile"]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    //MARK: Functions
    private func fbLogOut() {
        let fbManager: LoginManager = LoginManager()
        fbManager.logOut()
        logger.info("FB logout")
    }
    
    //MARK: Actions
    @IBAction func btnSignUpPressed(_ sender: Any) {
        SignUpViewController.present(over: self, identityDelegate: self)
    }
    
    @IBAction func unwindToRoot(segue:UIStoryboardSegue!) {
        Identity.logout()
    }
}

//MARK: - IdentityDelegate
extension RootViewController: IdentityDelegate {
    func cancel() {
        fbLogOut()
    }
    
    func signUp(user: User, userHandler: @escaping ((User) -> Void), errorHandler: @escaping ((Error) -> Void)) {
        Identity.signUp(user: user, userHandler: { (user) in
            userHandler(user)
        }) { (error) in
            Identity.logout()
            errorHandler(error)
        }
    }
    
    func login(user: String, password: String, socialId: String? = nil, userHandler: @escaping ((User) -> Void), errorHandler: @escaping ((Error) -> Void)) {
        Identity.login(user: user, password: password, socialId: socialId, userHandler: { (user) in
            userHandler(user)
        }) { (error) in
            Identity.logout()
            errorHandler(error)
        }
    }
}

//MARK: - FBSDKLoginManagerLoginResult
extension RootViewController: LoginButtonDelegate {
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
        Identity.logout()
    }
    
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
        if (error != nil) {
            KVNProgress.showError(withStatus: error?.localizedDescription)
        } else if result!.isCancelled {
        } else {
          self.fbRequestData()
        }
    }
    
    func fbRequestData() {
        let graphRequest = GraphRequest(graphPath: "me", parameters: ["fields": "id, name, email, link, first_name, last_name, birthday, location, gender, timezone"])
        graphRequest.start(completionHandler:  { (connection, result, error) in
            
            let user = result as? NSDictionary
            
            if ((error) != nil)
            {
                print("Error: \(error?.localizedDescription)")
            }
            else
            {
                let fbId = user?.value(forKey: "id") as? String
                
                self.login(user: "", password: "", socialId: fbId, userHandler: { (user) in
                    logger.info("Login with FB")
                    SceneDelegate.shared.showMainScreen()
                }) { (error) in
                    logger.info("Sign up with FB")
                    let fbUser = FBUser(
                                        id: fbId,
                                        email: user?.value(forKey: "email") as? String,
                                        name: user?.value(forKey: "name") as? String,
                                        first_name: user?.value(forKey: "first_name") as? String,
                                        last_name: user?.value(forKey: "last_name") as? String
                    )
                    SignUpViewController.present(over: self, identityDelegate: self, fbUser: fbUser)
                }
            }
        })
    }
}
