//
//  OrderActiveViewController.swift
//  deliApp
//
//  Created by iJPe on 14/10/19.
//  Copyright © 2019 reliae. All rights reserved.
//

import Foundation
import UIKit
import KVNProgress
import MapKit

class OrderActiveViewController: UIViewController {
    
    var orderId: String!
    var order: Order!
    
    @IBOutlet weak var map: MKMapView!
    @IBOutlet weak var imgStatus: UIImageView!
    @IBOutlet weak var lblStoreName: UILabel!
    @IBOutlet weak var lblTotal: UILabel!
    @IBOutlet weak var lblCourrierName: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    
    class func open(withId orderId: String, on navigationController: UINavigationController) {
        let vc = UIStoryboard(name: "OrderActive", bundle: nil)
          .instantiateViewController(withIdentifier: "orderActive") as! OrderActiveViewController
        
        vc.orderId = orderId
        navigationController.pushViewController(vc, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        commonInit()
        loadOrderInformation()
    }
    
    override var isViewLoaded: Bool {
        navigationController?.customTransparentPrimaryNavigationBar()
        return super.isViewLoaded
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.isNavigationBarHidden = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    //MARK: Functions
    private func commonInit() {

    }
    
    private func configureMap() {
        let coordinate = CLLocationCoordinate2D(latitude: order.store!.locationLatitude!, longitude: order.store!.locationLongitude!)
        let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: CLLocationDistance(exactly: 200)!, longitudinalMeters: CLLocationDistance(exactly: 200)!)
        map.setRegion(region, animated: true)
    }
    
    private func updateInformation() {
        logger.info("Showing order info")
//        configureMap()
        
        lblStoreName.text = order.store?.name
//        lblTotal.text = "\(order.orderPayment!.total!)"
    }
    
    private func loadOrderInformation() {
        OrderServices.loadOrder(id: orderId, successHandler: { (order) in
            self.order = order
            self.updateInformation()
        }) { (error) in
            KVNProgress.showError(withStatus: error.localizedDescription)
        }
    }
}
