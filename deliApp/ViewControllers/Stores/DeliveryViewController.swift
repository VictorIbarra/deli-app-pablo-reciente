//
//  DeliveryViewController.swift
//  deliApp
//
//  Created by iJPe on 26/03/20.
//  Copyright © 2020 reliae. All rights reserved.
//

import UIKit
import CoreLocation
import SkeletonView

class DeliveryViewController: UIViewController {
    private var deliveries: [Delivery]!
    private var locationReady = false
    private var cartLoaded = false
    private var ads: [Ad]!
    
    @IBOutlet weak var tbl: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        layout()
    }
    
    override var isViewLoaded: Bool {
        navigationController?.customPrimaryNavigationBar()
        return super.isViewLoaded
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
        checkEssentialInformation()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        NotificationCenter.default.addObserver(self, selector: #selector(locationUpdated(notification:)), name: Notification.Name("locationUpdated"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(cartLoaded(notification:)), name: Notification.Name("cartLoaded"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(addressUpdated(notification:)), name: Notification.Name("addressUpdated"), object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    //MARK: Functions
    private func configure() {
        tbl.dataSource = self
        tbl.delegate = self
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    private func layout() {
        let animation = SkeletonAnimationBuilder().makeSlidingAnimation(withDirection: .topLeftBottomRight)
        tbl.showAnimatedGradientSkeleton(animation: animation)
        
        let cellIdentifier = String(describing: CellAd.self)
        let nib = UINib(nibName: cellIdentifier, bundle: nil)
        collectionView.isHidden = true
        collectionView.register(nib, forCellWithReuseIdentifier: cellIdentifier)
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        
        tbl.isScrollEnabled = false
        tbl.bounces = false
        scrollView.bounces = true
    }
    
    private func reloadCollectionViews() {
        collectionView.reloadData()
    }
    
    private func setAddress() {
        if let addressText = Identity.shared.cart.data?.addressText {
            navigationItem.leftBarButtonItem = UIBarButtonItem.custom(with: addressText.trunc(length: 28, trailing: ""), icon: UIImage(named: "outline_arrow_drop_down_circle_black_24pt"))
            let gesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(openAddresses))
            navigationItem.leftBarButtonItem!.customView!.addGestureRecognizer(gesture)
        }
    }
    
    private func checkEssentialInformation() {
        if Identity.shared.cart.data != nil {
            cartLoaded = true
        }
        
        if Location.shared.last != nil {
            locationReady = true
        }
        
        if cartLoaded && locationReady {
            if Identity.shared.cart.data.addressLocation == nil {
                Identity.shared.cart.data.addressLocation = Location.shared.last.coordinate
                self.loadAds()
                self.loadStoresAround()
                
                Location.getAddressFrom(latitude: Identity.shared.cart.data!.addressLocation.latitude, longitude: Identity.shared.cart.data!.addressLocation.longitude) { (locationAddress) in
                    let cartAddress = Identity.shared.cart.data.address
                    cartAddress.city = locationAddress?.city
                    cartAddress.address = locationAddress?.address
                    Identity.shared.cartExtra.addressName = locationAddress!.address1!
                    self.setAddress()
                }
            } else {
                setAddress()
                loadAds()
                loadStoresAround()
            }
        } else {
            logger.info("Essential info incomplete")
        }
    }
    
    private func loadStoresAround() {
        // Tuxtla 16.751565, -93.103963
        logger.info("LOCATION")
        StoreServices.around(fromLocation: Identity.shared.cart.data!.addressLocation, around: 20, successHandler: { (deliveries) in
            self.deliveries = deliveries
            self.storesLoaded()
        }) { (error) in
            logger.error(error)
        }
    }
    
    private func storesLoaded() {
        tbl.hideSkeleton(transition: .crossDissolve(0.5))
        tbl.reloadData()
        collectionView.isHidden = false
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "updateStoreList"), object: self, userInfo: nil)
    }
    
    private func loadAds() {
        AdServices.loadAds(on: Identity.shared.cart.data!.addressLocation, successHandler: { (ads) in
            self.ads = ads
            self.reloadCollectionViews()
        }) { (error) in
            logger.error(error)
        }
    }
    
    private func addressUpdated() {
        loadStoresAround()
        loadAds()
        setAddress()
    }
    
    @objc func cartLoaded(notification: NSNotification!) {
        checkEssentialInformation()
    }
    
    @objc func locationUpdated(notification: NSNotification!) {
        checkEssentialInformation()
    }
    
    @objc func addressUpdated(notification: NSNotification!) {
        addressUpdated()
    }
    
    @objc func openAddresses() {
        AddressesViewController.present(over: self, addressDelegate: self)
    }
}

extension DeliveryViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let y = self.scrollView.contentOffset.y
        let h = collectionView.frame.height
        
//        if scrollView == tbl {
//            if y <= 0 {
//                tbl.isScrollEnabled = false
//            } else {
//                tbl.isScrollEnabled = true
//            }
//        } else {
            if h - y > 0 {
                tbl.isScrollEnabled = false
            } else {
                tbl.isScrollEnabled = true
            }
//        }
    }
}

//MARK: - UITableViewDataSource
extension DeliveryViewController: SkeletonTableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return deliveries != nil ? deliveries.count : 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! CellDelivery
        cell.configure(delivery: deliveries[indexPath.row])
        return cell
    }
    
    //MARK: Skeleton
    func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return "cell"
    }
}

//MARK: - UITableViewDelegate
extension DeliveryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        StoresViewController.push(forDelivery: deliveries[indexPath.row], ads: ads, after: self)
    }
}

//MARK: - AddressDelegate
extension DeliveryViewController: AddressDelegate {
    func select(_ address: AddressModel) {
        Identity.shared.cart.extra.addressName = address.label!
        Identity.shared.cart.data?.addressText = address.address!
        Identity.shared.cart.data?.addressLocation = CLLocationCoordinate2D(latitude: address.location_latitude, longitude: address.location_longitude)
        addressUpdated()
        
        CartServices.update(isAddressUpdated: true, successHandler: { (cart) in
            logger.info("Address updated on cart")
        }) { (error) in
            logger.error(error)
        }
    }
}

//MARK: - UICollectionViewDataSource
extension DeliveryViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ads != nil ? ads.count : 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellIdentifier = String(describing: CellAd.self)
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! CellAd
        cell.configure(ad: ads[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension DeliveryViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
}
