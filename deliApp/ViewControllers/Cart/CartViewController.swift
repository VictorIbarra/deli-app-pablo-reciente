//
//  CartViewController.swift
//  deliApp
//
//  Created by iJPe on 11/13/18.
//  Copyright © 2018 reliae. All rights reserved.
//

import Foundation
import UIKit
import KVNProgress
import CoreData
import MapKit
import Device
import SwipeCellKit
import Openpay

//MARK: CellCartDetail
class CellCartDetail: SwipeTableViewCell {
    @IBOutlet var lblNumberLine: UILabel!
    @IBOutlet var lblName: UILabel!
    @IBOutlet var lblPrice: UILabel!
    
    func configure(item: Item) {
        lblNumberLine.text = "\(item.quantity!)"
        lblName.text = item.itemName
        let price = Double(item.quantity!) * item.itemPrice!
        lblPrice.text = String(describing: price).currencyFormatting()
    }
}

//MARK: - CartViewProtocol
protocol CartViewProtocol {
    var viewCart: UIView! { get set }
    var lblCartInfo: UILabel! { get set }
    
    func updateCartInfo(quantity: Int, total: Double)
}

//MARK: - CartViewController
class CartViewController: JPCustomViewController {

    var fetchedResultsAddress: NSFetchedResultsController<NSFetchRequestResult>!
    var address: CartAddress!
    var card: Card!
    var cards: [Card] = []
    var storePaymentMethod: PaymentMethod!
    var paymentGatewaySelected: PaymentGateway!
    var opDeviceSessionId: String!
    
    @IBOutlet weak var tbl: UITableView!
    @IBOutlet weak var lblAddressName: UILabel!
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var btnChange: UIButton!
    @IBOutlet weak var lblStoreTime: UILabel!
    @IBOutlet weak var lblStoreName: UILabel!
    @IBOutlet weak var lblSubtotal: UILabel!
    @IBOutlet weak var lblShipping: UILabel!
    @IBOutlet weak var lblCoupon: UILabel!
    @IBOutlet weak var lblCouponCode: UILabel!
    @IBOutlet weak var lblDeliCashForUse: UILabel!
    @IBOutlet weak var lblDelivery: UILabel!
    @IBOutlet weak var lblTotal: UILabel!
    @IBOutlet weak var lblDeliCash: UILabel!
    @IBOutlet weak var switchDeliCash: UISwitch!
    @IBOutlet weak var btnConfirm: UIButton!
    @IBOutlet weak var svCart: UIStackView!
    @IBOutlet weak var lblEmptyCart: UILabel!
    @IBOutlet weak var map: MKMapView!
    @IBOutlet weak var lblCardNumber: UILabel!
    @IBOutlet weak var txtCouponCode: UITextField!
    @IBOutlet weak var btnValidateCode: UIButton!
    @IBOutlet weak var svCouponCode: UIStackView!
    @IBOutlet weak var btnPaymentMethod: UIButton!
    @IBOutlet weak var lblNotes: UITextView!
    @IBOutlet weak var viewCash: UIView!
    @IBOutlet weak var svCard: UIStackView!
    @IBOutlet weak var segPaymentMethods: UISegmentedControl!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        if segue.identifier == "go_payment" {
            let vc = segue.destination as! PaymentMethodsViewController
            vc.paymentId = paymentGatewaySelected.id!
            vc.paymentDelegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        layout()
        configure()
        setCartInformation()
    }
    
    //MARK: Functions
    private func layout() {
        storePaymentMethod = Identity.shared.cart.extra.storePaymentMethod
        svCouponCode.isHidden = true
        checkPaymentMethodSelected()
        buildSegmentedPaymentMethods()
    }
    
    private func buildSegmentedPaymentMethods() {
        segPaymentMethods.removeAllSegments()
        var i = 0
        for g in storePaymentMethod.gateways {
            segPaymentMethods.insertSegment(withTitle: g.name, at: i, animated: false)
            i = i + 1
        }
        
        if storePaymentMethod.cash {
            segPaymentMethods.insertSegment(withTitle: "Efectivo", at: i, animated: false)
        }
        
        segPaymentMethods.selectedSegmentIndex = 0
        paymentMethodSegmentedValueChanged(segPaymentMethods)
    }
    
    private func configure() {
        self.address = Identity.shared.cart.data?.address
        tbl.dataSource = self
        
        createOpenPayDeviceSessionId()
    }
    
    private func createOpenPayDeviceSessionId() {
        let openpay = Openpay(withMerchantId: Env.Openpay.merchantId, andApiKey: Env.Openpay.apiKey, isProductionMode: Env.Openpay.production, isDebug: !Env.Openpay.production)
        openpay.createDeviceSessionId(successFunction: { (sessionId) in
            self.opDeviceSessionId = sessionId
        }) { (error) in
            logger.error(error.localizedDescription)
        }
    }
    
    private func setCartInformation() {
        setAddressInformation()
        if Identity.shared.cart.data != nil {
            let totalItem = Identity.shared.cart.data.total
            let deliveryCost = Identity.shared.cart.extra.deliveryCost
            var grandTotal = totalItem + deliveryCost
            
            lblStoreTime.text = "\(Identity.shared.cart.data!.store!.deliveryTime!) min"
            lblStoreName.text = Identity.shared.cart.data?.store?.name
            lblSubtotal.text = String(describing: totalItem).currencyFormatting()
            lblShipping.text = "SHIP"
            lblCoupon.text = ""
            
            var deliCashForUse = 0.0
            if switchDeliCash.isOn {
                if Identity.shared.user!.wallet! > grandTotal {
                    deliCashForUse = -grandTotal
                } else {
                    deliCashForUse = -Identity.shared.user!.wallet!
                }
            }
                
            grandTotal = grandTotal + deliCashForUse
            lblDeliCashForUse.text = String(describing: deliCashForUse).currencyFormatting()
            lblDelivery.text = String(describing: deliveryCost).currencyFormatting()
            lblTotal.text = String(describing: grandTotal).currencyFormatting()
            lblDeliCash.text = "DeliCash \(String(describing: Identity.shared.user!.wallet!).currencyFormatting())"
            
            svCart.isHidden = false
            lblEmptyCart.isHidden = true
            
            tbl.reloadData()
        } else {
            svCart.isHidden = true
            lblEmptyCart.isHidden = false
        }
    }
    
    private func setAddressInformation() {
        if address != nil {
            lblAddressName.text = Identity.shared.cart.extra.addressName
            lblAddress.text = address.address
            let coordinate = address.locationCoordinate
            
            let span = MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
            let region = MKCoordinateRegion(center: coordinate, span: span)
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinate
            
            map.setRegion(region, animated: false)
            map.centerCoordinate = coordinate
            map.addAnnotation(annotation)
        }
    }
    
    private func setPaymentInformation() {
        if let c = card {
            lblCardNumber.text = "**** \(c.lastFour ?? "")"
            btnPaymentMethod.setTitle("Cambiar", for: .normal)
        } else {
            lblCardNumber.text = ""
        }
    }
    
    func updateCart(invoice: Bool = false) {
        KVNProgress.show(withStatus: "Saving...")
        
        let userDetails = UserDetail()
        userDetails.countryPhoneCode = (Identity.shared.user?.countryPhoneCode)!
        userDetails.email = (Identity.shared.user?.email)!
        userDetails.name = "\(Identity.shared.user?.firstName ?? "") \(Identity.shared.user!.lastName ?? "")"
        userDetails.phone = (Identity.shared.user?.phone)!
        
        Identity.shared.cart.data!.destinationAddresses![0].note = ""
        Identity.shared.cart.data!.destinationAddresses![0].userDetails = userDetails
        Identity.shared.cart.data!.pickupAddresses![0].note = ""
        Identity.shared.cart.data!.pickupAddresses![0].userDetails = userDetails
        
        CartServices.update(successHandler: { (cart) in
            if invoice {
                self.getInvoice()
            } else {
                if let od = Identity.shared.cart.data?.orderDetails {
                    if  od.count <= 0 {
                        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "cartUpdated"), object: self, userInfo: nil)
                        self.dismiss(animated: true)
                    } else {
                        self.setCartInformation()
                        self.tbl.reloadData()
                    }
                }
                KVNProgress.dismiss()
            }
        }) { (error) in
            logger.error(error)
            self.tbl.reloadData()
            KVNProgress.showError(withStatus: error.localizedDescription)
        }
    }
    
    func getInvoice() {
        CartServices.createOrder(for: Identity.shared.cart.data!.id!, payWith: card.id!, cvv: "123", opDeviceSessionId: opDeviceSessionId, successHandler: { (cart) in
            Identity.shared.cart.clear()
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "cartUpdated"), object: self, userInfo: nil)
            KVNProgress.showSuccess(withStatus: "Orden creada", completion: {
                self.dismiss()
            })
        }) { (error) in
            logger.error(error)
            KVNProgress.showError(withStatus: "Please try again \(error)")
        }
    }
    
    func removeProduct(indexSection: Int, indexRow: Int) {
        Identity.shared.cart.data?.remove(indexOrderDetail: indexSection, indexItem: indexRow)
        updateCart(invoice: false)
    }
    
    func validateAndConfirmOrder() {
        
        do {
            if self.card == nil {
                throw CustomError.validationError("Favor de seleccionar una tarjeta")
            }
        } catch CustomError.validationError(let message) {
            KVNProgress.showError(withStatus: message)
            return
        } catch let error {
            KVNProgress.showError(withStatus: error.localizedDescription)
            return
        }
        
        let alert = UIAlertController(title: "Carrito", message: "Confirmar orden?", preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "Continuar", style: .default, handler: { (action: UIAlertAction!) in
            self.updateCart(invoice: true)
        }))
        
        alert.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    private func checkPaymentMethodSelected(paymentId: String! = nil, cash: Bool = false) {
        if paymentId != nil {
            svCard.isHidden = false
            viewCash.isHidden = true
        } else {
            svCard.isHidden = true
            viewCash.isHidden = false
        }
    }
    
    private func selectDefaultCard() {
        for c in cards {
            if c.isDefault! {
                self.card = c
                setPaymentInformation()
                break
            }
        }
    }
    
    private func openAddresses() {
        AddressesViewController.present(over: self, addressDelegate: self)
    }
    
    //MARK: Actions
    @IBAction func confirmOrder(_ sender: Any) {
        validateAndConfirmOrder()
    }
    
    @IBAction func validateCode(_ sender: Any) {
        if txtCouponCode.text?.count ?? 0 > 0 {
            lblCouponCode.text = self.txtCouponCode.text
            svCouponCode.isHidden = false
        } else {
            svCouponCode.isHidden = true
        }
    }
    
    @IBAction func removeCouponCode(_ sender: Any) {
        svCouponCode.isHidden = true
        txtCouponCode.text = ""
    }
    
    @IBAction func paymentMethodSegmentedValueChanged(_ sender: Any) {
        if segPaymentMethods.selectedSegmentIndex <= storePaymentMethod.gateways.count - 1 {
            paymentGatewaySelected = storePaymentMethod.gateways[segPaymentMethods.selectedSegmentIndex]
            cards = Card.fetch(paymentId: paymentGatewaySelected.id)
            checkPaymentMethodSelected(paymentId: paymentGatewaySelected.id)
            selectDefaultCard()
        } else {
            checkPaymentMethodSelected(cash: true)
        }
    }
    
    @IBAction func mapTapped(_ sender: Any) {
        MapPointViewController.present(location: Identity.shared.cart.data!.addressLocation, over: self)
    }
    
    @IBAction func changeAddressWasPressed(_ sender: Any) {
        openAddresses()
    }
}

//MARK: - SwipeTableViewCellDelegate
extension CartViewController: SwipeTableViewCellDelegate {
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        guard orientation == .right else { return nil }
        
        let deleteAction = SwipeAction(style: .destructive, title: nil) { action, indexPath in
            self.removeProduct(indexSection: indexPath.section, indexRow: indexPath.row)
        }
        
        // customize the action appearance
        deleteAction.image = UIImage(named: "baseline_delete_outline_black_18pt")
        
        return [deleteAction]
    }
}

//MARK: - UITableViewDataSource
extension CartViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return Identity.shared.cart.data!.orderDetails!.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Identity.shared.cart.data!.orderDetails![section].items?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CellCartDetail
        cell.configure(item: Identity.shared.cart.data!.orderDetails![indexPath.section].items![indexPath.row])
        
        cell.tag = indexPath.row
        cell.delegate = self
        return cell
    }
}

//MARK: - AddressDelegate
extension CartViewController: AddressDelegate {
    func select(_ address: AddressModel) {
        Identity.shared.cart.extra.addressName = address.label!
        Identity.shared.cart.data?.addressText = address.address!
        Identity.shared.cart.data?.addressLocation = CLLocationCoordinate2D(latitude: address.location_latitude, longitude: address.location_longitude)
        
        CartServices.update(isAddressUpdated: true, successHandler: { (cart) in
            self.setCartInformation()
        }) { (error) in
            KVNProgress.showError(withStatus: error.localizedDescription)
            logger.error(error)
        }
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "addressUpdated"), object: self, userInfo: nil)
    }
}

//MARK: - PaymentDelegate
extension CartViewController: PaymentDelegate {
    func select(_ card: Card) {
        self.card = card
        setPaymentInformation()
    }
}
