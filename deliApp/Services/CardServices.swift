//
//  CardServices.swift
//  deliApp
//
//  Created by iJPe on 26/02/20.
//  Copyright © 2020 reliae. All rights reserved.
//

import UIKit
import CoreData

class CardServices {
    static func loadCards(successHandler: @escaping (([Card]) -> Void) = { _ in }, errorHandler: @escaping ((String) -> Void) = { _ in }) {
        API.card.loadCards(for: Identity.shared.user!.id!) { (response, error) in
            if let e = error {
                errorHandler(e.localizedDescription)
            } else {
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                let context = appDelegate.persistentContainer.viewContext
                let entity = NSEntityDescription.entity(forEntityName: "CardModel", in: context)
                
                let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: "CardModel")
                let request = NSBatchDeleteRequest(fetchRequest: fetch)
                
                do {
                    try context.execute(request)
                } catch {
                    errorHandler("Failed delete")
                }
                
                for card in response!.cards! {
                    let c = NSManagedObject(entity: entity!, insertInto: context)
                    c.setValue(card.id, forKey: "id")
                    c.setValue(card.paymentID, forKey: "payment_id")
                    c.setValue(card.lastFour, forKey: "last_four")
                    c.setValue(card.isDefault, forKey: "is_default")
                    c.setValue(card.cardExpiryDate, forKey: "card_expiry_date")
                    c.setValue(card.cardHolderName, forKey: "card_holder_name")
                    
                    do {
                        try context.save()
                    } catch {
                        errorHandler("Failed saving station")
                    }
                }
                
                successHandler(response!.cards!)
            }
        }
    }
    
    static func addCard(paymentId: String, cardToken: String, opDeviceSessionId: String! = nil, successHandler: @escaping ((String) -> Void), errorHandler: @escaping ((String) -> Void)) {
        API.card.addCard(for: Identity.shared.user!.id!, paymentId: paymentId, cardToken: cardToken, opDeviceSessionId: opDeviceSessionId) { (response, error) in
            if let e = error {
                errorHandler(e.localizedDescription)
            } else {
                CardServices.loadCards(successHandler: { (_) in
                    successHandler(response!.message!)
                }) { (_) in
                    errorHandler("No ha sido posible actualizar el listado")
                }
            }
        }
    }
    
    static func deleteCard(id: String, successHandler: @escaping ((String) -> Void), errorHandler: @escaping ((String) -> Void)) {
        API.card.deleteCard(id: id) { (response, error) in
            if let e = error {
                errorHandler(e.localizedDescription)
            } else {
                CardServices.loadCards(successHandler: { (_) in
                    successHandler(response!.message!)
                }) { (_) in
                    errorHandler("No ha sido posible actualizar el listado")
                }
            }
        }
    }
}
