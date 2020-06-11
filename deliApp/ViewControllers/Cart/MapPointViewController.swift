//
//  MapPointViewController.swift
//  deliApp
//
//  Created by iJPe on 6/4/19.
//  Copyright © 2019 reliae. All rights reserved.
//

import Foundation
import UIKit
import MapKit
import Presentr

//MARK: - MapPointViewController
class MapPointViewController: JPCustomViewController {
    
    var location: CLLocationCoordinate2D!
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
    
    @IBOutlet var map: MKMapView!
    
    static func present(location: CLLocationCoordinate2D, over viewController: UIViewController) {
        let vc = UIStoryboard(name: "Cart", bundle: nil).instantiateViewController(withIdentifier: "mapPointVC") as! MapPointViewController
        vc.location = location
        presentr.viewControllerForContext = viewController
        viewController.customPresent(viewController: vc, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setPin()
    }
    
    //MARK: Functions
    func setPin() {
        let span = MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
        let region = MKCoordinateRegion(center: location, span: span)
        let annotation = MKPointAnnotation()
        annotation.coordinate = location
        
        map.setRegion(region, animated: false)
        map.centerCoordinate = location
        map.addAnnotation(annotation)
    }
}
