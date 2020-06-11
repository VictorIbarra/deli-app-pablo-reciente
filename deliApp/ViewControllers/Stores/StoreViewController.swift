//
//  StoreViewController.swift
//  deliApp
//
//  Created by iJPe on 10/23/18.
//  Copyright © 2018 reliae. All rights reserved.
//

import UIKit
import XLPagerTabStrip
import KVNProgress
import Presentr

//MARK: - StoreViewController
class StoreViewController: ButtonBarPagerTabStripViewController, CartViewProtocol {

    private var storeId: String!
    private var store: Store!
    private var products: [Product] = []
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
    
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblRating: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var viewCart: UIView!
    @IBOutlet weak var lblCartInfo: UILabel!
    @IBOutlet weak var btnFavorite: UIButton!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        NotificationCenter.default.addObserver(self, selector: #selector(cartUpdated(notification:)), name: Notification.Name("cartUpdated"), object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    static func push(forStoreId storeId: String, after viewController: UIViewController) {
        let vc = UIStoryboard(name: "Stores", bundle: nil).instantiateViewController(withIdentifier: "storeVC") as! StoreViewController
        vc.storeId = storeId
        viewController.navigationController?.pushViewController(vc, animated: true)
    }
    
    static func present(storeId: String, over viewController: UIViewController) {
        let vc = UIStoryboard(name: "Stores", bundle: nil).instantiateViewController(withIdentifier: "storeVC") as! StoreViewController
        vc.storeId = storeId
        presentr.viewControllerForContext = viewController
        viewController.customPresent(viewController: vc, animated: true, presentr: presentr, completion: nil)
    }
    
    override func viewDidLoad() {
        configureTabs()
        super.viewDidLoad()
        getStore()
    }
    
    override var isViewLoaded: Bool {
        navigationController?.customTransparentPrimaryNavigationBar()
        return super.isViewLoaded
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
        updateCartLayout()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    //MARK: PagerTabStripDataSource
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        let storyboard = UIStoryboard(name: "Stores", bundle: Bundle.main)
        
        if products.isEmpty {
            return [storyboard.instantiateViewController(withIdentifier: "storeCategoryVC") as! StoreProductViewController]
        }
        
        var t: [StoreProductViewController] = []
        for i in 0...products.count - 1 {
            let vc = StoreProductViewController.configure(forProduct: products[i])
            t.append(vc)
        }
        
        return t
    }
    
    //MARK: Functions
    private func configureTabs() {
        self.buttonBarView.collectionViewLayout = UICollectionViewFlowLayout()
        
        self.settings.style.buttonBarBackgroundColor = UIColor.white
        self.settings.style.buttonBarItemBackgroundColor = UIColor.white
        self.settings.style.selectedBarBackgroundColor = UIColor.Deli.primaryRed
        self.settings.style.selectedBarHeight = 2.0
        self.settings.style.buttonBarMinimumLineSpacing = 0
        self.settings.style.buttonBarItemTitleColor = UIColor.white
        
        self.settings.style.buttonBarLeftContentInset = 16
        self.settings.style.buttonBarRightContentInset = 16
        
        changeCurrentIndexProgressive = { (oldCell: ButtonBarViewCell?, newCell: ButtonBarViewCell?, progressPercentage: CGFloat, changeCurrentIndex: Bool, animated: Bool) -> Void in
            guard changeCurrentIndex == true else { return }
            oldCell?.label.textColor = UIColor.Deli.darkGrey
            newCell?.label.textColor = UIColor.Deli.primaryRed
        }
    }
    
    private func layout() {
        img.sd_setImage(with: URL(string: "\(Env.Deli.hostImages)\(self.store.imageURL!)"))
        lblName.text = store.name
        lblRating.text = "\(store.userRate!)"
        lblTime.text = "\(store.deliveryTime!) min"
        lblPrice.text = "Precio: \(store.priceRating!)"
        
        layoutFavorite()
    }
    
    private func layoutFavorite() {
        if store.isFavorite() {
            btnFavorite.tintColor = UIColor.Deli.primaryRed
        } else {
            btnFavorite.tintColor = UIColor.Deli.lightGrey
        }
    }
    
    private func getStore() {
        KVNProgress.show(withStatus: "Cargando...")
        
        StoreServices.getStore(withId: storeId, successHandler: { (store) in
            self.store = store
            self.layout()
            self.loadProducts()
            
            KVNProgress.dismiss()
        }) { (error) in
            KVNProgress.showError(withStatus: error.localizedDescription, completion: {
                self.goToBack(sender: self)
            })
        }
    }
    
    private func loadProducts() {
        ProductServices.loadProducts(for: store.id!, successHandler: { (products) in
            self.products = products
            self.reloadPagerTabStripView()
        }) { (error) in
            KVNProgress.showError(withStatus: error.localizedDescription)
        }
    }
    
    private func make(storeId: String, favorite: Bool) {
        StoreServices.make(storeId: storeId, favorite: favorite, forUserId: Identity.shared.user!.id!, successHandler: { (success) in
            self.layoutFavorite()
        }) { (error) in
            KVNProgress.showError(withStatus: error)
        }
    }
    
    @objc func cartUpdated(notification: NSNotification!) {
        updateCartLayout()
    }
    
    //MARK: Actions
    @IBAction func goToBack(sender: Any) {
        self.view.endEditing(true)
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnFavoriteWasPressed(_ sender: Any) {
        make(storeId: store.id!, favorite: !store.isFavorite())
    }
}

//MARK: - ViewActiveCartDelegate
extension StoreViewController: ViewActiveCartDelegate {
    func updateCartLayout() {
        viewCart.isHidden = true
        if Identity.shared.cart.data?.orderDetails!.count ?? 0 > 0 {
            viewCart.isHidden = false
            updateCartInfo(quantity: Identity.shared.cart.data!.productQuantity, total: Identity.shared.cart.data?.total ?? 0)
        }
    }
    
    func updateCartInfo(quantity: Int, total: Double) {
        lblCartInfo.text = "\(quantity) Productos - \(String(describing: total).currencyFormatting())"
    }
}
