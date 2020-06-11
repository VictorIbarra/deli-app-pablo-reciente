//
//  Card.swift
//  deliApp
//
//  Created by iJPe on 12/4/18.
//  Copyright © 2018 reliae. All rights reserved.
//

import CoreData
import UIKit

class Card: Codable {
    var id: String?
    var cardExpiryDate, cardHolderName, cardType: String?
    var createdAt: String?
    var customerID, deviceSessionID, lastFour: String?
    var isDefault: Bool?
    var paymentID, paymentToken: String?
    var uniqueId: Int?
    var userID: String?

    enum CodingKeys: String, CodingKey {
        case id
        case cardExpiryDate = "card_expiry_date"
        case cardHolderName = "card_holder_name"
        case cardType = "card_type"
        case createdAt = "created_at"
        case customerID = "customer_id"
        case deviceSessionID = "device_session_id"
        case isDefault = "is_default"
        case lastFour = "last_four"
        case paymentID = "payment_id"
        case paymentToken = "payment_token"
        case uniqueId = "unique_id"
        case userID = "user_id"
    }
    
    init(id: String?, cardExpiryDate: String?, cardHolderName: String?, cardType: String?, createdAt: String?, customerID: String?, deviceSessionID: String?, isDefault: Bool?, lastFour: String?, paymentID: String?, paymentToken: String?, uniqueId: Int?, userID: String?) {
        self.id = id
        self.cardExpiryDate = cardExpiryDate
        self.cardHolderName = cardHolderName
        self.cardType = cardType
        self.createdAt = createdAt
        self.customerID = customerID
        self.deviceSessionID = deviceSessionID
        self.isDefault = isDefault
        self.lastFour = lastFour
        self.paymentID = paymentID
        self.paymentToken = paymentToken
        self.uniqueId = uniqueId
        self.userID = userID
    }
    
    init(id: String?, cardExpiryDate: String?, cardHolderName: String?, isDefault: Bool?, lastFour: String?, paymentID: String?) {
        self.id = id
        self.cardExpiryDate = cardExpiryDate
        self.cardHolderName = cardHolderName
        self.isDefault = isDefault
        self.lastFour = lastFour
        self.paymentID = paymentID
    }
    
    static func fetch(paymentId: String? = nil) -> [Card] {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let fetchedResults: NSFetchedResultsController<NSFetchRequestResult>!
        let fetchRequest = NSFetchRequest<CardModel>(entityName: "CardModel")
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "payment_id", ascending: true)]
        
        fetchedResults = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil) as! NSFetchedResultsController<NSFetchRequestResult>
        
        if let paymentId = paymentId {
            fetchedResults.fetchRequest.predicate = NSPredicate(format: "(payment_id contains [cd] %@)", paymentId)
        }
        
        do {
            try fetchedResults.performFetch()
            
            var cards: [Card] = []
            for cModel in fetchedResults.fetchedObjects! as! [CardModel] {
                cards.append(Card.modelToClass(cModel))
            }
            
            return cards
        } catch {
            logger.error("Failed to fetch entities: \(error)")
            return []
        }
    }
    
    static func modelToClass(_ cardModel: CardModel) -> Card {
        return Card.init(id: cardModel.id, cardExpiryDate: cardModel.card_expiry_date, cardHolderName: cardModel.card_holder_name, isDefault: cardModel.is_default, lastFour: cardModel.last_four, paymentID: cardModel.payment_id)
    }
}
