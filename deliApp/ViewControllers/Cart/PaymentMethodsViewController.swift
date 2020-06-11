//
//  PaymentMethodsViewController.swift
//  deliApp
//
//  Created by iJPe on 11/20/18.
//  Copyright © 2018 reliae. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import KVNProgress
import SwiftyJSON
import SwipeCellKit
import Openpay

//MARK: - CellCreditCard
class CellCreditCard: SwipeTableViewCell {
    @IBOutlet var lblCardNumber: UILabel!
}

//MARK: - PaymentDelegate
protocol PaymentDelegate {
    func select(_ card: Card)
}

//MARK: - PaymentMethodsViewController
class PaymentMethodsViewController: JPCustomViewController {
    
    var paymentId: String = Env.Deli.defaultPaymentId
    var cards: [Card] = []
    var json_cards: JSON!
    var paymentDelegate: PaymentDelegate!
    var isModal = true
    var openpay: Openpay!
    var opDeviceSessionId: String = ""
    
    @IBOutlet var tbl: UITableView!
    @IBOutlet var viewTitle: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        loadPaymentMethods()
    }
    
    override var isViewLoaded: Bool {
        navigationController?.customTransparentWhiteNavigationBar()
        return super.isViewLoaded
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if !isModal {
            self.viewTitle.isHidden = true
            self.navigationController?.isNavigationBarHidden = false
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if !isModal {
            self.navigationController?.isNavigationBarHidden = true
        }
    }
    
    //MARK: Functions
    private func configure() {
        tbl.dataSource = self
        tbl.delegate = self
    }
    
    private func openStripe() {
//        let themeViewController = StripeThemeViewController()
//        let theme = themeViewController.theme.stpTheme
//        
//        let config = STPPaymentConfiguration()
//        config.publishableKey = "pk_test_igjkUS0V1Z0uXEwdSvqKHMM7"
//        config.requiredBillingAddressFields = .full
//        
//        let viewController = STPAddCardViewController(configuration: config, theme: theme)
//        viewController.delegate = self
//        let navigationController = UINavigationController(rootViewController: viewController)
//        navigationController.navigationBar.stp_theme = theme
//        present(navigationController, animated: true, completion: nil)
    }
    
    private func openOpenPay() {
        openpay = Openpay(withMerchantId: Env.Openpay.merchantId, andApiKey: Env.Openpay.apiKey, isProductionMode: Env.Openpay.production, isDebug: !Env.Openpay.production)
        openpay.createDeviceSessionId(successFunction: { (sessionId) in
            self.opDeviceSessionId = sessionId
        }) { (error) in
            logger.error(error.localizedDescription)
        }
        openpay.loadCardForm(in: self, successFunction: successCard, failureFunction: failCard, formTitle: "Add card")
    }
    
    private func saveCard(_ token: String, opDeviceSessionId: String! = nil) {
        KVNProgress.show(withStatus: "Guardando...")
        
        CardServices.addCard(paymentId: paymentId, cardToken: token, opDeviceSessionId: opDeviceSessionId, successHandler: { (success) in
            self.loadPaymentMethods()
            KVNProgress.dismiss()
        }) { (error) in
            KVNProgress.showError(withStatus: error)
        }
    }
    
    private func loadPaymentMethods() {
        cards = Card.fetch(paymentId: paymentId)
        tbl.reloadData()
    }
    
    //MARK: - Openpay
    func successCard() {
        openpay.createTokenWithCard(address: nil, successFunction: successToken, failureFunction: failToken)
    }

    func failCard(error: NSError) {
        logger.error("\(error.code) - \(error.localizedDescription)")
        OperationQueue.main.addOperation {
            KVNProgress.showError(withStatus: "Error al validar tarjeta")
        }
    }

    func successToken(token: OPToken) {
        logger.info("TokenID: \(token.id)")
        OperationQueue.main.addOperation {
            self.saveCard(token.id, opDeviceSessionId: self.opDeviceSessionId)
        }
    }

    func failToken(error: NSError) {
        print("\(error.code) - \(error.localizedDescription)")
    }
    
    //MARK: Actions
    @IBAction func close(_ sender: Any) {
        if isModal {
            self.dismiss()
        } else {
            self.goToBack(sender: sender)
        }
    }
    
    @IBAction func add(_ sender: Any) {
        openOpenPay()
    }
}

//MARK: - UITableViewDataSource, UITableViewDelegate
extension PaymentMethodsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cards.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CellCreditCard
        cell.lblCardNumber.text = "**** \(self.cards[indexPath.row].lastFour ?? "")"
        cell.tag = indexPath.row
        
        cell.delegate = self
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let delegate = self.paymentDelegate {
            delegate.select(self.cards[indexPath.row])
            self.dismiss(animated: true, completion: nil)
        }
    }
}

//MARK: - STPAddCardViewControllerDelegate
//extension PaymentMethodsViewController: STPAddCardViewControllerDelegate {
//    func addCardViewControllerDidCancel(_ addCardViewController: STPAddCardViewController) {
//       addCardViewController.dismiss(animated: true, completion: nil)
//    }
//
//    func addCardViewController(_ addCardViewController: STPAddCardViewController, didCreateToken token: STPToken, completion: @escaping STPErrorBlock) {
//        saveCard(token.description)
//        addCardViewController.dismiss(animated: true, completion: nil)
//    }
//}

//MARK: - SwipeTableViewCellDelegate
extension PaymentMethodsViewController: SwipeTableViewCellDelegate {
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        guard orientation == .right else { return nil }
        
        let deleteAction = SwipeAction(style: .destructive, title: nil) { action, indexPath in
            CardServices.deleteCard(id: self.cards[indexPath.row].id!, successHandler: { (message) in
                self.loadPaymentMethods()
            }) { (error) in
                KVNProgress.showError(withStatus: error)
            }
        }
        
        // customize the action appearance
        deleteAction.image = UIImage(named: "baseline_delete_outline_black_24pt")
        
        return [deleteAction]
    }
}
