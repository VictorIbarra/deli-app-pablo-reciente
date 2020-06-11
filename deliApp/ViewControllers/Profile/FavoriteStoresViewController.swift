//
//  FavoriteStoresViewController.swift
//  deliApp
//
//  Created by iJPe on 8/15/19.
//  Copyright © 2019 reliae. All rights reserved.
//

import Foundation
import UIKit
import KVNProgress

//MARK: - FavoriteStoresViewController
class FavoriteStoresViewController: UIViewController {
    
    @IBOutlet weak var tbl: UITableView!
    
    var stores: [Store]!
    
    static func push(after viewController: UIViewController) {
        let vc = UIStoryboard(name: "Profile", bundle: nil).instantiateViewController(withIdentifier: "favoriteStoreVC") as! FavoriteStoresViewController
        viewController.navigationController?.pushViewController(vc, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Lugares favoritos"
        configure()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        reloadTable()
    }
    
    private func configure() {
        let cellStore = String(describing: CellStore.self)
        let nibCellStore = UINib(nibName: cellStore, bundle: nil)
        tbl.register(nibCellStore, forCellReuseIdentifier: cellStore)
        
        tbl.dataSource = self
        tbl.delegate = self
    }
    
    private func reloadTable() {
        stores = Identity.shared.user!.favoriteStores
        tbl.reloadData()
    }
}

//MARK: - UITableViewDataSource
extension FavoriteStoresViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.stores?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellStore", for: indexPath) as! CellStore
        cell.configure(for: stores[indexPath.row], favoriteDelegate: self)
        
        return cell
    }
}

//MARK: - UITableViewDelegate
extension FavoriteStoresViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let store = stores[indexPath.row]
        StoreViewController.present(storeId: store.id!, over: self)
    }
}

//MARK: - FavoriteDelegate
extension FavoriteStoresViewController: FavoriteDelegate {
    func make(storeId: String, favorite: Bool) {
        StoreServices.make(storeId: storeId, favorite: favorite, forUserId: Identity.shared.user!.id!, successHandler: { (success) in
            self.tbl.reloadData()
        }) { (error) in
            KVNProgress.showError(withStatus: error)
        }
    }
}
