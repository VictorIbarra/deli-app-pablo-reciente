//
//  ReferralCodeViewController.swift
//  deliApp
//
//  Created by iJPe on 8/15/19.
//  Copyright © 2019 reliae. All rights reserved.
//

import Foundation
import UIKit
import Presentr

//MARK: - ReferralCodeViewController
class ReferralCodeViewController: JPCustomViewController {
    
    @IBOutlet var lblCode: UILabel!
    @IBOutlet var btnShare: UIButton!
    
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
    
    static func present(over viewController: UIViewController) {
        let vc = UIStoryboard(name: "Profile", bundle: nil).instantiateViewController(withIdentifier: "referralVC") as! ReferralCodeViewController
        presentr.viewControllerForContext = viewController
        viewController.customPresent(viewController: vc, animated: true, presentr: presentr, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lblCode.text = Identity.shared.user?.referralCode!
    }
    
    func share() {
        let activityViewController = UIActivityViewController(activityItems: [lblCode.text!], applicationActivities: nil)
        activityViewController.excludedActivityTypes = [
            UIActivity.ActivityType.airDrop,
            UIActivity.ActivityType.print,
            UIActivity.ActivityType.assignToContact,
            UIActivity.ActivityType.postToWeibo,
            UIActivity.ActivityType.addToReadingList,
            UIActivity.ActivityType.postToVimeo,
            UIActivity.ActivityType.postToTencentWeibo
        ]
        
        OperationQueue.main.addOperation {
            self.present(activityViewController, animated: true, completion: nil)
        }
    }
    
    //MARK: Actions
    @IBAction func btnSharePressed(_ sender: Any) {
        self.share()
    }
}
