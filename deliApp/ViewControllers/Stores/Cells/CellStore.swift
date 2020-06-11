//
//  CellStore.swift
//  deliApp
//
//  Created by iJPe on 6/28/19.
//  Copyright © 2019 reliae. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import KVNProgress
import SwiftyJSON

//MARK: - FavoriteDelegate
protocol FavoriteDelegate {
    func make(storeId: String, favorite: Bool)
}

//MARK: - CellStore
class CellStore: UITableViewCell {
    
    var store: Store!
    var favoriteDelegate: FavoriteDelegate!
    
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var lblClosed: UILabel!
    @IBOutlet weak var btnFavorite: UIButton!
    
    //MARK: Functions
    func configure(for store: Store, favoriteDelegate: FavoriteDelegate! = nil) {
        self.store = store
        self.favoriteDelegate = favoriteDelegate
        layout()
    }
    
    func configure(for storeModel: StoreModel, favoriteDelegate: FavoriteDelegate! = nil) {
        let store = Store()
        store.id = storeModel.id
        store.imageURL = storeModel.image_url
        store.name = storeModel.name
        store.isOpenNow = storeModel.is_open_now
        configure(for: store, favoriteDelegate: favoriteDelegate)
    }
    
    //MARK: Functions
    private func layout() {
        var url = "http://deliapp.mx/wp-content/uploads/2018/07/f1.jpg"
        if let image = store.imageURL {
            url = "\(Env.Deli.hostImages)\(image)"
        }
        img?.sd_setImage(with: URL(string: url))
        lblName.text = store.name
        lblClosed.isHidden = store.isOpenNow ?? false
        
        if store.isFavorite() {
            btnFavorite.tintColor = UIColor.Deli.primaryRed
        } else {
            btnFavorite.tintColor = UIColor.Deli.lightGrey
        }
        
        selectionStyle = .none
    }
    
    //MARK: Actions
    @IBAction func btnFavoriteWasPressed(_ sender: Any) {
        favoriteDelegate.make(storeId: store.id!, favorite: !store.isFavorite())
    }
}
