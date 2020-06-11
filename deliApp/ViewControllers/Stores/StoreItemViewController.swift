//
//  StoresDishViewContollers.swift
//  deliApp
//
//  Created by iJPe on 10/27/18.
//  Copyright © 2018 reliae. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON
import KVNProgress
import Alamofire
import Device
import Presentr
//import IQKeyboardManager

//MARK: - CellSpecificationDelegate
protocol CellSpecificationListDelegate {
    func tapped(specification: ProductSpecification, list: ProductList, selected: Bool)
}

//MARK: - StoreItemViewController
class StoreItemViewController: JPCustomViewController {
    
    var itemId: String!
    var product: Product!
    var item: ProductItem!
    var quantity = 1
    var totalPrice = 0.0
    var totalSpecificationPrice = 0.0
    var arraySelectedLists: [String] = []
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
    
    @IBOutlet weak var tbl: UITableView!
    @IBOutlet weak var lblProductName: UILabel!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var lblAdditionals: UILabel!
    @IBOutlet weak var txtQuantity: UITextField!
    @IBOutlet weak var txtNotes: UITextView!
    @IBOutlet weak var btnDown: UIButton!
    @IBOutlet weak var btnUp: UIButton!
    @IBOutlet weak var btnAdd: UIButton!
    
    static func present(itemId: String, over viewController: UIViewController) {
        let vc = UIStoryboard(name: "Stores", bundle: nil).instantiateViewController(withIdentifier: "storeItemVC") as! StoreItemViewController
        vc.itemId = itemId
        presentr.viewControllerForContext = viewController
        viewController.customPresent(viewController: vc, animated: true, presentr: presentr, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getItem()
    }
    
    //MARK: Functions
    private func configure() {
        tbl.dataSource = self
        
        configureKeyboard()
        selectDefaultSpecifications()
    }
    
    private func layout() {
        lblProductName.text = item.name
        lblDescription.text = item.details
        if item.imageURL?.count ?? 0 > 0 {
            img.sd_setImage(with: URL(string: "\(Env.Deli.hostImages)\(item.imageURL![0])"))
        } else {
            img.isHidden = true
        }
        
        txtQuantity.text = "\(quantity)"
        updateTotal()
        
        if item.specifications?.count ?? 0 <= 0 {
            lblAdditionals.isHidden = true
        }
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
    
    private func updateTotal() {
        totalPrice = item.price! * Double(quantity)
        let total = self.totalPrice + (totalSpecificationPrice * Double(quantity))
        self.btnAdd.setTitle("Agregar al carrito (\(String(describing: total).currencyFormatting()))", for: .normal)
    }
    
    private func selectDefaultSpecifications() {
        item.specifications!.forEach { (specification) in
            specification.list?.forEach({ (list) in
                if list.isDefaultSelected! {
                    arraySelectedLists.append(list.id!)
                    totalSpecificationPrice += Double(list.price!)
                }
            })
        }
    }
    
    private func getItem() {
        ProductServices.getItem(for: itemId, successHandler: { (item, product) in
            self.item = item
            self.product = product
            self.configure()
            self.layout()
        }) { (error) in
            self.dismiss()
        }
    }
    
    private func addToCart() {
        let cart = Identity.shared.cart.data
        
        let item = Item() //Product
        item.quantity = quantity
        item.itemName = self.item.name
        item.imageURL = []
        item.itemID = self.item.id
        item.details = self.item.details
        item.maxItemQuantity = 10
        item.noteForItem = txtNotes.text
        item.uniqueId = self.item.uniqueId
        item.itemPrice = self.item.price
        item.totalItemAndSpecificationPrice = 0.0
        item.totalSpecificationPrice = 0.0
        
        self.item.specifications?.forEach { (spec) in
            let specification = Specification()
            specification.price = 0.0
            spec.list?.forEach { (lst) in
                if arraySelectedLists.lastIndex(of: lst.id!) != nil {
                    let list = ItemSpecification()

                    list.isDefaultSelected = lst.isDefaultSelected!
                    list.uniqueId = lst.uniqueId!
                    list.id = lst.id!
                    list.price = lst.price!
                    list.name = lst.name!
                    list.isUserSelected = lst.isUserSelected!

                    specification.list.append(list)
                    specification.price = specification.price + list.price
                }
            }
            specification.type = spec.type!
            specification.name = spec.name!
            specification.uniqueId = spec.uniqueId!
            item.specifications?.append(specification)
            item.totalSpecificationPrice = item.totalSpecificationPrice! + specification.price
        }
        
        item.totalItemAndSpecificationPrice = (item.itemPrice! + item.totalSpecificationPrice!) * Double(item.quantity!)

        var added = false
        cart?.orderDetails?.forEach({ (detail) in
            if product.id == detail.productId {
                detail.totalItemPrice = detail.totalItemPrice! + item.totalItemAndSpecificationPrice!
                detail.items?.append(item)
                added = true
            }
        })

        if added == false {
            let order_detail = OrderDetail()
            order_detail.productId = product.id
            order_detail.totalItemPrice = item.totalItemAndSpecificationPrice!
            if order_detail.items == nil {
                order_detail.items = []
            }
            order_detail.items?.append(item)
            order_detail.uniqueId = product.uniqueId
            order_detail.productName = product.name

            if cart?.orderDetails == nil {
                cart?.orderDetails = []
            }
            cart?.orderDetails?.append(order_detail)    
        }
        
        Identity.shared.cart.data?.storeId = product.storeId
        saveCart()
    }
    
    private func saveCart() {
        KVNProgress.show(withStatus: "Guardando...")
        CartServices.update(successHandler: { (cart) in
            KVNProgress.dismiss {
                self.dismiss(animated: true)
            }
        }) { (error) in
            KVNProgress.showError(withStatus: error.localizedDescription)
        }
    }
    
    private func clearCart(completion: @escaping (Bool) -> ()) {
        CartServices.clear(successHandler: { (cart) in
            completion(true)
        }) { (error) in
            KVNProgress.showError(withStatus: error.localizedDescription)
            completion(false)
        }
    }
    
    //MARK: Actions
    @IBAction func changeQuantity(_ sender: UIButton) {
        switch sender {
        case btnDown:
            if quantity > 1 {
                quantity = quantity - 1
                totalPrice -= item.price!
            }
        case btnUp:
            quantity = quantity + 1
            totalPrice += item.price!
        default:
            break
        }
        
        txtQuantity.text = "\(quantity)"
        updateTotal()
    }
    
    @IBAction func addToCart(_ sender: Any) {
        if Identity.shared.cart.data!.storeId?.count ?? 0 > 0 && Identity.shared.cart.data!.storeId != item.storeId && Identity.shared.cart.data!.orderDetails?.count ?? 0 > 0 {
            let alert = UIAlertController(title: "Carrito", message: "¿Deseas iniciar el carrito para este restaurante?", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Aceptar", style: .default, handler: { (action: UIAlertAction!) in
                alert.dismiss(animated: false) {
                    self.clearCart { (success) in
                        if success {
                            self.addToCart()
                        }
                    }
                }
            }))
            alert.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: nil))
            
            present(alert, animated: true, completion: nil)
        } else {
            addToCart()
        }
    }
}

//MARK: - CellSpecificationListDelegate
extension StoreItemViewController: CellSpecificationListDelegate {
    func tapped(specification: ProductSpecification, list: ProductList, selected: Bool) {
        if specification.type == 1 && selected {
            specification.list?.forEach { (l) in
                if let i = arraySelectedLists.lastIndex(of: l.id!) {
                    arraySelectedLists.remove(at: i)
                    totalSpecificationPrice -= l.price!
                }
            }
        }
        
        if selected {
            arraySelectedLists.append(list.id!)
            totalSpecificationPrice += list.price!
        } else {
            let i = arraySelectedLists.lastIndex(of: list.id!)
            arraySelectedLists.remove(at: i!)
            totalSpecificationPrice -= list.price!
        }
        
        if specification.type == 1 && selected {
            tbl.reloadData()
        }
        
        updateTotal()
    }
}

//MARK: - UITableViewDataSource
extension StoreItemViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return item.specifications?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return item.specifications![section].list?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return item.specifications![section].name
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CellSpecificationList
        let specification = item.specifications![indexPath.section]
        let list = specification.list![indexPath.row]
        list.isSelected = false
        if arraySelectedLists.lastIndex(of: list.id!) != nil {
            list.isSelected = true
        }
        cell.configure(specification: specification, list: list, delegate: self)
        
        return cell
    }
}
