//
//  FBLoginViewController.swift
//  Flencer
//
//  Created by Garsa on 7/11/18.
//  Copyright © 2018 Garsa. All rights reserved.
//

import Foundation
import KVNProgress
import FBSDKLoginKit

//MARK: - FBLoginViewController
class FBLoginViewController: JPCustomViewController, LoginButtonDelegate {
    
    @IBOutlet weak var loginButton: FBLoginButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.loginButton.delegate = self
        self.loginButton.permissions = ["public_profile", "email"]
    }
    
    //MARK: FBSDKLoginButtonDelegate
    func loginButton(_ loginButton: FBLoginButton!, didCompleteWith result: LoginManagerLoginResult!, error: Error!) {
        if error == nil {
            if !result.isCancelled {
                
                if result.grantedPermissions.contains("email") {
                    
                    let graphRequest : GraphRequest = GraphRequest(graphPath: "me", parameters: ["fields" : "id, email, name"])
                    graphRequest.start(completionHandler: { (connection, result, error) -> Void in
                        if ((error) != nil) {
                            print("Error: \(error)")
                        } else {
                            let id = ((result as AnyObject).value(forKey: "id") as? String)!
                            let name = ((result as AnyObject).value(forKey: "name") as? String)!
                            let email = ((result as AnyObject).value(forKey: "email") as? String)!
                            
                            self.facebookLogin(id: id, name: name, email: email)
                        }
                    })
                }
            }
        } else {
            KVNProgress.showError(withStatus: error.localizedDescription)
        }
    }
    
    func loginButtonDidLogOut(_ loginButton: FBLoginButton!) {
        print("Facebook logout")
    }
    
    //MARK: Functions
    func facebookLogin(id: String, name: String, email: String) {
        print("Id: \(id)")
        print("Name: \(name)")
        print("Email: \(email)")
    }
}
