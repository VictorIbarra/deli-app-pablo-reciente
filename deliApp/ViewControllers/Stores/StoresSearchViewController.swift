//
//  StoresSearchViewController.swift
//  deliApp
//
//  Created by iJPe on 10/17/18.
//  Copyright © 2018 reliae. All rights reserved.
//

import Foundation
import UIKit

//MARK: - StoresSearchViewController
class StoresSearchViewController: JPCustomViewController, UITableViewDataSource {
    
    @IBOutlet var tbl: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tbl.dataSource = self
    }
    
    //MARK: UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "\(indexPath.row)"
        return cell
    }
}
