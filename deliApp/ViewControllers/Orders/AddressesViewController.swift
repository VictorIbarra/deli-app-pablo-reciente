//
//  OrderAddressViewController.swift
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
import CoreData
import SwipeCellKit
//import IQKeyboardManagerSwift
import Device
import Presentr

//MARK: - AddressDelegate
protocol AddressDelegate {
    func select(_ address: AddressModel)
}

//MARK: - OrderAddressViewController
class AddressesViewController: JPCustomViewController {
    
    var json_address: JSON!
    var fetchedResults: NSFetchedResultsController<NSFetchRequestResult>!
    let searchController = UISearchController(searchResultsController: nil)
    var addressDelegate: AddressDelegate!
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
    
    @IBOutlet var viewAdd: UIView!
    @IBOutlet var viewTitle: UIView!
    @IBOutlet var tbl: UITableView!
    @IBOutlet var txtSearch: UITextField!
    
    static func present(over viewController: UIViewController, addressDelegate: AddressDelegate) {
        let aVC = UIStoryboard(name: "Addresses", bundle: nil).instantiateViewController(withIdentifier: "addressesVC") as! AddressesViewController
        aVC.addressDelegate = addressDelegate
        presentr.viewControllerForContext = viewController
        viewController.customPresent(viewController: aVC, animated: true, presentr: presentr)
    }
    
    static func push(after viewController: UIViewController, addressDelegate: AddressDelegate! = nil) {
        let aVC = UIStoryboard(name: "Addresses", bundle: nil).instantiateViewController(withIdentifier: "addressesVC") as! AddressesViewController
        if let delegate = addressDelegate {
            aVC.addressDelegate = delegate
        }
        viewController.navigationController?.pushViewController(aVC, animated: true)
    }
    
    override var isViewLoaded: Bool {
        navigationController?.customSecondaryNavigationBar()
        return super.isViewLoaded
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTitle()
        configure()
        configureKeyboard()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        var selectionMode = false
        if addressDelegate != nil {
            selectionMode = true
        }
        
        navigationController?.isNavigationBarHidden = selectionMode
        viewTitle.isHidden = !selectionMode
        fetchAddresses()
    }
    
    //MARK: Functions
    private func setTitle() {
        if addressDelegate == nil {
            title = "Direcciones"
        } else {
            title = ""
        }
    }
    
    private func configure() {
        if addressDelegate != nil {
            self.viewAdd.isHidden = false
        } else {
            self.viewAdd.isHidden = true
        }
        
        searchController.obscuresBackgroundDuringPresentation = false
        definesPresentationContext = true

        tbl.dataSource = self
        tbl.delegate = self

        self.txtSearch.delegate = self
        self.txtSearch.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }
    
    fileprivate func configureKeyboard() {
//        IQKeyboardManager.shared.enable = true
//        IQKeyboardManager.shared.toolbarTintColor = UIColor.Deli.primaryRed
//        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
//        switch Device.size() {
//        case .screen3_5Inch, .screen4Inch:
//            // Small screens
//            // Nothing
//            break
//        default:
//            IQKeyboardManager.shared.enableAutoToolbar = false
//            break
//        }
    }
    
    func searchBarIsEmpty() -> Bool {
        // Returns true if the text is empty or nil
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    func isFiltering() -> Bool {
        return (self.txtSearch.text?.count)! > 0
    }
    
    func filterContentForSearchText(_ searchText: String) {
        
        self.fetchedResults.fetchRequest.predicate = NSPredicate(format: "(label contains [cd] %@)", searchText)
        do {
            try self.fetchedResults.performFetch()
            self.tbl.reloadData()
        } catch {
            print("Error filtrando")
        }
    }
    
    private func fetchAddresses() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<AddressModel>(entityName: "AddressModel")
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "label", ascending: true)]
        self.fetchedResults = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil) as? NSFetchedResultsController<NSFetchRequestResult>
        do {
            try self.fetchedResults.performFetch()
        } catch {
            fatalError("Failed to fetch entities: \(error)")
        }
        
        tbl.reloadData()
    }
    
    private func newAddress() {
        SearchAddressViewController.present(over: self)
    }
    
    //MARK: Actions
    @IBAction func close(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func unwindToListAddresses(segue:UIStoryboardSegue!) {
        fetchAddresses()
    }
    
    @IBAction func newAddressWasPressed(_ sender: Any) {
        newAddress()
    }
}

//MARK: - UITableViewDataSource
extension AddressesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.fetchedResults?.fetchedObjects!.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CellAddress
        
        guard let a: AddressModel = self.fetchedResults?.object(at: indexPath) as? AddressModel else {
            fatalError("No Address")
        }
        
        cell.lblName.text = a.label
        cell.lblAddress.text = a.address
        cell.imgIsDefault.isHidden =  true
        
        if a.is_default {
            cell.imgIsDefault.isHidden =  false
        }
        
        cell.tag = indexPath.row
        cell.delegate = self
        return cell
    }
}
//MARK: - UITableViewDelegate
extension AddressesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let a: AddressModel = self.fetchedResults?.object(at: indexPath) as? AddressModel else {
            fatalError("No Address")
        }
        
        if let d = self.addressDelegate {
            d.select(a)
            close(tableView)
        }
    }
}

//MARK: - UITextFieldDelegate
extension AddressesViewController: UITextFieldDelegate {
    @objc func textFieldDidChange(_ textField: UITextField) {
        self.filterContentForSearchText(textField.text!)
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.closeKeyboard()
        return true
    }
}

// MARK: - UISearchResultsUpdating
extension AddressesViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(self.txtSearch.text!)
    }
}

//MARK: - SwipeTableViewCellDelegate
extension AddressesViewController: SwipeTableViewCellDelegate {
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        guard orientation == .right else { return nil }
        
        let deleteAction = SwipeAction(style: .destructive, title: "") { action, indexPath in
            let a: AddressModel = (self.fetchedResults?.object(at: indexPath) as? AddressModel)!
            
            AddressServices.deleteAddress(id: a.id!, successHandler: { (success) in
                self.fetchAddresses()
            }) { (error) in
                KVNProgress.showError(withStatus: error)
            }
        }
        
        // customize the action appearance
        deleteAction.image = UIImage(named: "baseline_delete_outline_black_36pt")
        
        return [deleteAction]
    }
}
