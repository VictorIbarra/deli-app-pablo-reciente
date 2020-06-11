//
//  SearchAddressViewController.swift
//  deliApp
//
//  Created by iJPe on 5/13/19.
//  Copyright © 2019 reliae. All rights reserved.
//

import Foundation
import UIKit
import MapKit
import Presentr

//MARK: - SearchAddressViewController
class SearchAddressViewController: JPCustomViewController {
    
    let searchController = UISearchController(searchResultsController: nil)
    var matchingItems:[MKMapItem] = []
    var isModal = false
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
    
    @IBOutlet weak var searchBarContainer: UIView!
    @IBOutlet weak var tbl: UITableView!
    
    static func present(over viewController: UIViewController) {
        let vc = UIStoryboard(name: "Addresses", bundle: nil).instantiateViewController(withIdentifier: "searchAddressVC") as! SearchAddressViewController
        let navC = UINavigationController(rootViewController: vc)
        navC.customSecondaryNavigationBar()
        presentr.viewControllerForContext = viewController
        viewController.customPresent(viewController: navC, animated: true, presentr: presentr, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        layout()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        DispatchQueue.main.async {
            self.searchController.isActive = true
            self.searchController.searchBar.becomeFirstResponder()
        }
    }
    
    //MARK: Functions
    private func configure() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.requestLocation(withAccuracy: kCLLocationAccuracyBest)
        tbl.dataSource = self
        tbl.delegate = self
    }
    
    private func layout() {
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
            searchController.searchBar.backgroundColor = .black
        }
        
        navigationItem.searchController = searchController
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.searchController.searchBar.becomeFirstResponder()
        }
    }
    
    func searchBarIsEmpty() -> Bool {
        // Returns true if the text is empty or nil
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    func isFiltering() -> Bool {
        return searchController.isActive && !searchBarIsEmpty()
    }
    
    func filterContentForSearchText(_ searchText: String) {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = searchText
        request.region = MKCoordinateRegion(center: Location.shared.last.coordinate, latitudinalMeters: 50000.0, longitudinalMeters: 50000.0)
        let search = MKLocalSearch(request: request)
        search.start { response, _ in
            guard let response = response else {
                return
            }
            self.matchingItems = response.mapItems
            self.tbl.reloadData()
        }
    }
    
    func close() {
        if isModal {
            self.dismiss()
        } else {
            self.goToBack(sender: self)
        }
    }
    
    private func addAddressWith(_ locationAddress: LocationAddress) {
        AddAddressesViewController.present(locationAddress: locationAddress, over: self)
    }
    
    //MARK: Actions
    @IBAction func close(_ sender: Any) {
        self.close()
    }
    
    @IBAction func new(_ sender: Any) {
        self.performSegue(withIdentifier: "go_new", sender: sender)
    }
}

//MARK: - UITableViewDataSource, UITableViewDelegate
extension SearchAddressViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.matchingItems.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let i = indexPath.row - 1
        if i < 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cellLocation", for: indexPath)
            return cell
        }
        
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        cell.textLabel?.text = self.matchingItems[i].placemark.title
        cell.detailTextLabel?.text = self.matchingItems[i].placemark.title
        cell.tag = i
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let i = indexPath.row - 1
        var locationAddress = LocationAddress()
        if i < 0 {
            locationAddress.latitude = Location.shared.last.coordinate.latitude
            locationAddress.longitude = Location.shared.last.coordinate.longitude
        } else {
            locationAddress.address = self.matchingItems[i].placemark.title
            locationAddress.latitude = self.matchingItems[i].placemark.coordinate.latitude
            locationAddress.longitude = self.matchingItems[i].placemark.coordinate.longitude
        }
        
        addAddressWith(locationAddress)
    }
}

//MARK: - UISearchBarDelegate
extension SearchAddressViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        filterContentForSearchText(searchBar.text!)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        dismiss(animated: true)
    }
}

//MARK: - UISearchResultsUpdating
extension SearchAddressViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
}
