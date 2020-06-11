//
//  ProfileViewController.swift
//  deliApp
//
//  Created by iJPe on 12/16/18.
//  Copyright © 2018 reliae. All rights reserved.
//

import Foundation
import UIKit

//MARK: - ProfileViewController
class ProfileViewController: UIViewController {
    
    @IBOutlet var imgUser: UIImageView!
    @IBOutlet var lblName: UILabel!
    @IBOutlet var lblEmail: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        commonInit()
    }
    
    override var isViewLoaded: Bool {
        navigationController?.customTransparentWhiteNavigationBar(isTranslucent: false)
        return super.isViewLoaded
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
    }
//
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//        navigationController?.isNavigationBarHidden = true
//    }
    
    func commonInit() {
//        title = ""
        
        imgUser.sd_setImage(with: URL(string: "\(Env.Deli.hostImages)\(Identity.shared.user!.imageURL!)"))
        lblName.text = "\(Identity.shared.user!.firstName!)  \(Identity.shared.user!.lastName!)"
        lblEmail.text = Identity.shared.user?.email
    }
}

//MARK: - ProfileMenuTableViewController
class ProfileMenuTableViewController: UITableViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "go_payment_methods" {
            (segue.destination as? PaymentMethodsViewController)?.isModal = false
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            self.performSegue(withIdentifier: "go_payment_methods", sender: indexPath)
        case 1:
            AddressesViewController.push(after: self)
        case 2:
            FavoriteStoresViewController.push(after: self)
        case 3:
            ReferralCodeViewController.present(over: self)
            break
        case 4:
//            self.performSegue(withIdentifier: "go_payment_methods", sender: indexPath)
            break
        case 5:
            Identity.logout()
            SceneDelegate.shared.showRoot()
        default:
            break
        }
    }
}
