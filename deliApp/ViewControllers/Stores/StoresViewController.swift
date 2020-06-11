//
//  StoresViewController.swift
//  deliApp
//
//  Created by iJPe on 10/17/18.
//  Copyright © 2018 reliae. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import KVNProgress
import SwiftyJSON
import SDWebImage
import CoreData
import CoreLocation

//MARK: - ActiveCartViewDelegate
protocol ViewActiveCartDelegate {
    var viewCart: UIView! { get set }
    var lblCartInfo: UILabel! { get set }
    
    func updateCartLayout()
    func updateCartInfo(quantity: Int, total: Double)
}

//MARK: - StoresViewController
class StoresViewController: JPCustomViewController, CartViewProtocol {
    private var fetchedResults: NSFetchedResultsController<NSFetchRequestResult>!
    private let searchController = UISearchController(searchResultsController: nil)
    private var address: AddressModel!
    private var delivery: Delivery!
    private var ads: [Ad] = []
    
    private var isSearchBarEmpty: Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    var isFiltering: Bool {
        return searchController.isActive && !isSearchBarEmpty
    }
    
    @IBOutlet weak var tbl: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var txtSearchStore: UITextField!
    @IBOutlet weak var viewCart: UIView!
    @IBOutlet weak var lblCartInfo: UILabel!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        NotificationCenter.default.addObserver(self, selector: #selector(cartUpdated(notification:)), name: Notification.Name("cartUpdated"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(updateStoreList(notification:)), name: Notification.Name("updateStoreList"), object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    static func push(forDelivery delivery: Delivery, ads: [Ad]? = nil, after viewController: UIViewController) {
        let vc = UIStoryboard(name: "Stores", bundle: nil).instantiateViewController(withIdentifier: "storesVC") as! StoresViewController
        vc.delivery = delivery

        if let ads = ads {
            vc.ads = ads
        }
        
        viewController.navigationController?.pushViewController(vc, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
        configure()
        fetchStores()
    }
    
    override var isViewLoaded: Bool {
        navigationController?.customPrimaryNavigationBar()
        return super.isViewLoaded
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
        updateCartLayout()
        tbl.reloadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    //MARK: Functions
   private func configure() {
        tbl.dataSource = self
        tbl.delegate = self
        collectionView.dataSource = self
        collectionView.delegate = self
        
        let cellIdentifier = String(describing: CellAd.self)
        let nib = UINib(nibName: cellIdentifier, bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: cellIdentifier)
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
    
        let cellStore = String(describing: CellStore.self)
        let nibCellStore = UINib(nibName: cellStore, bundle: nil)
        tbl.register(nibCellStore, forCellReuseIdentifier: cellStore)
    }
    
    private func layout() {
        setTitle()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "baseline_search_black_24pt"), style: .plain, target: self, action: #selector(showSearchBar))
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Buscar"
        searchController.searchBar.keyboardType = UIKeyboardType.asciiCapable
        searchController.searchBar.delegate = self
        searchController.hidesNavigationBarDuringPresentation = true
        navigationItem.hidesSearchBarWhenScrolling = true
        definesPresentationContext = true
        
        if #available(iOS 13, *) {
            searchController.searchBar.searchTextField.backgroundColor = .white
            searchController.searchBar.backgroundColor = .white
        }

        viewCart.isHidden = true
    }
    
    @objc private func showSearchBar() {
        navigationItem.searchController = searchController
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.searchController.searchBar.becomeFirstResponder()
        }
    }
    
    private func setTitle(title: String, titleColor: UIColor, titleSize: Int, subtitle: String, subtitleColor: UIColor, subtitleSize: Int , view: UIView) -> UIView {
        let titleLabel = UILabel(frame: CGRect(x:0, y:-5, width: view.frame.width - 100, height: 20))

        titleLabel.backgroundColor = UIColor.clear
        titleLabel.textColor = titleColor
        titleLabel.adjustsFontSizeToFitWidth = false
        titleLabel.font = UIFont.boldSystemFont(ofSize: CGFloat(titleSize))
        titleLabel.lineBreakMode = .byTruncatingTail
        titleLabel.textAlignment = .center
        titleLabel.text = title
        
        let subtitleLabel = UILabel(frame: CGRect(x:0, y:18, width: view.frame.width - 100, height: 10))
        subtitleLabel.backgroundColor = UIColor.clear
        subtitleLabel.textColor = subtitleColor
        subtitleLabel.adjustsFontSizeToFitWidth = false
        subtitleLabel.lineBreakMode = .byTruncatingTail
        subtitleLabel.textAlignment = .center
        subtitleLabel.font = UIFont.systemFont(ofSize: CGFloat(subtitleSize))
        subtitleLabel.text = subtitle
        
        let titleView = UIView(frame: CGRect(x:0, y:0, width: view.frame.width - 30, height:30))
        titleView.addSubview(titleLabel)
        titleView.addSubview(subtitleLabel)

        return titleView
    }
    
    private func setTitle() {
//        navigationItem.titleView = setTitle(title: delivery.name!, titleColor: UIColor.Deli.darkGrey, titleSize: 16, subtitle: Identity.shared.cart.data!.addressText.trunc(length: 45, trailing: ""), subtitleColor: UIColor.Deli.lightGrey, subtitleSize: 10, view: self.view)
        title = delivery.name
    }
    
    private func fetchStores() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<StoreModel>(entityName: "StoreModel")
        if let id = delivery?.id {
            fetchRequest.predicate = NSPredicate(format: "delivery_id == '\(id)'")
        }
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        self.fetchedResults = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil) as? NSFetchedResultsController<NSFetchRequestResult>
        do {
            try self.fetchedResults.performFetch()
        } catch {
            fatalError("Failed to fetch entities: \(error)")
        }
        self.tbl.reloadData()
    }
    
    private func filterContentForSearchText(_ searchText: String) {
        if isFiltering {
            self.fetchedResults.fetchRequest.predicate = NSPredicate(format: "(name contains [cd] %@)", searchText)
        } else {
            self.fetchedResults.fetchRequest.predicate = nil
        }
        
        do {
            try self.fetchedResults.performFetch()
            self.tbl.reloadData()
        } catch {
            print("Error filtrando")
        }
    }
    
    @objc private func cartUpdated(notification: NSNotification!) {
        updateCartLayout()
    }
    
    @objc private func updateStoreList(notification: NSNotification!) {
        fetchStores()
    }
    
    //MARK: Actions
    @IBAction func searchStore(_ sender: Any) {
        self.txtSearchStore.isHidden = !self.txtSearchStore.isHidden
        if !self.txtSearchStore.isHidden {
            self.txtSearchStore.becomeFirstResponder()
        }
    }
}

//MARK: - UITableViewDataSource
extension StoresViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let c = fetchedResults?.fetchedObjects?.count {
            return c + 1
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row < fetchedResults?.fetchedObjects!.count ?? 0, let store: StoreModel = fetchedResults?.object(at: indexPath) as? StoreModel {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CellStore", for: indexPath) as! CellStore
            cell.configure(for: store, favoriteDelegate: self)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cellEmpty", for: indexPath)
            return cell
        }
    }
}

//MARK: - UITableViewDelegate
extension StoresViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row < fetchedResults?.fetchedObjects!.count ?? 0, let store: StoreModel = fetchedResults?.object(at: indexPath) as? StoreModel {
            StoreViewController.push(forStoreId: store.id!, after: self)
        } else {
            logger.info("Store not found")
        }
    }
}

//MARK: - ViewActiveCartDelegate
extension StoresViewController: ViewActiveCartDelegate {
    func updateCartLayout() {
        viewCart?.isHidden = true
        if Identity.shared.cart.data?.orderDetails!.count ?? 0 > 0 {
            viewCart.isHidden = false
            updateCartInfo(quantity: Identity.shared.cart.data!.productQuantity, total: Identity.shared.cart.data?.total ?? 0)
        }
    }
    
    func updateCartInfo(quantity: Int, total: Double) {
        lblCartInfo.text = "\(quantity) Productos - \(String(describing: total).currencyFormatting())"
    }
}

//MARK: - UISearchResultsUpdating
extension StoresViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        filterContentForSearchText(searchBar.text!)
    }
}

//MARK: - UISearchBarDelegate
extension StoresViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        filterContentForSearchText(searchBar.text!)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        navigationItem.searchController = nil
        navigationController!.view.setNeedsLayout()
        navigationController!.view.layoutIfNeeded()
    }
}

//MARK: - UICollectionViewDataSource
extension StoresViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ads.count
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
extension StoresViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
}

//MARK: - FavoriteDelegate
extension StoresViewController: FavoriteDelegate {
    func make(storeId: String, favorite: Bool) {
        StoreServices.make(storeId: storeId, favorite: favorite, forUserId: Identity.shared.user!.id!, successHandler: { (success) in
            self.tbl.reloadData()
        }) { (error) in
            KVNProgress.showError(withStatus: error)
        }
    }
}
