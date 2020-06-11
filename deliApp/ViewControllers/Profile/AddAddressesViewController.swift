//
//  AddressesViewController.swift
//  deliApp
//
//  Created by iJPe on 4/24/19.
//  Copyright © 2019 reliae. All rights reserved.
//

import Foundation
import UIKit
import MapKit
import Alamofire
import SwiftyJSON
import KVNProgress
import Presentr

//MARK: - AddAddressesViewController
class AddAddressesViewController: UIViewController {
    var locationAddress: LocationAddress!
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
    
    @IBOutlet weak var map: MKMapView!
    @IBOutlet weak var txtAddress: UITextView!
    @IBOutlet weak var txtInternalNumber: UITextField!
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtNotes: UITextView!
    @IBOutlet weak var btnSave: UIButton!
    @IBOutlet weak var btnClose: UIButton!
    
    override var isViewLoaded: Bool {
        navigationController?.customSecondaryNavigationBar()
        return super.isViewLoaded
    }
        
    static func present(locationAddress: LocationAddress, over viewController: UIViewController) {
        let vc = UIStoryboard(name: "Addresses", bundle: nil).instantiateViewController(withIdentifier: "addAddressVC") as! AddAddressesViewController
        vc.locationAddress = locationAddress
        presentr.viewControllerForContext = viewController
        viewController.customPresent(viewController: vc, animated: true, presentr: presentr, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        layout()
        configure()
        setInitialPointOnMap()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        navigationController?.isNavigationBarHidden = true
    }

    //MARK: Functions
    private func configure() {
        map.showsUserLocation = true
    }
    
    private func layout() {
        navigationController?.backButtonEmptyText()
    }
    
    private func setInitialPointOnMap() {
        let coordinate = CLLocationCoordinate2D(latitude: locationAddress.latitude!, longitude: locationAddress.longitude!)
        let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: CLLocationDistance(exactly: 200)!, longitudinalMeters: CLLocationDistance(exactly: 200)!)
        map.setRegion(region, animated: true)
        
        if let loc = self.locationAddress.address1 {
            self.txtAddress.text = loc
        } else {
            Location.getAddressFrom(latitude: locationAddress!.latitude!, longitude: locationAddress!.longitude!) { (loc) in
                self.locationAddress.address = loc?.address
                self.locationAddress.address1 = loc?.address1
                self.locationAddress.address2 = loc?.address2
                self.locationAddress.city = loc?.city
                self.locationAddress.state = loc?.state
                
                self.txtAddress.text = self.locationAddress.address
            }
        }
    }
    
    private func save() {
        let address = NewAddress()
        address.label = txtName.text
        address.address = txtAddress.text
        address.apt_no = txtInternalNumber.text
        address.description = txtNotes.text
        address.location = [map.centerCoordinate.latitude, map.centerCoordinate.longitude]
        
        AddressServices.save(address: address, forUserId: Identity.shared.user!.id!, successHandler: { (success) in
            KVNProgress.showSuccess(withStatus: "Dirección guardada!", completion: {
                self.performSegue(withIdentifier: "unwind_addresses", sender: self)
            })
        }) { (error) in
            KVNProgress.showError(withStatus: error.debugDescription)
        }
    }
    
    private func saveAddress() {
        do {
            if txtAddress.text!.count < 1 {
                throw CustomError.validationError("Favor de ingresar una dirección")
            }
            if txtName.text!.count < 1 {
                throw CustomError.validationError("Favor de ingresar un nombre")
            }
            save()
        } catch CustomError.validationError(let message) {
            KVNProgress.showError(withStatus: message)
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    //MARK: Actions
    @IBAction func btnSaveWasPressed(_ sender: Any) {
        saveAddress()
    }
    
    @IBAction func btnCancelWasPressed(_ sender: Any) {
        dismiss(animated: true)
    }
}

//extension AddressesViewController: MKMapViewDelegate {
//    func mapView(_ mapView: MKMapView, regionWillChangeAnimated animated: Bool) {
//
//        let location = CLLocation(latitude: mapView.centerCoordinate.latitude, longitude: mapView.centerCoordinate.longitude)
//        self.getAddressFrom(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
//    }
//}
