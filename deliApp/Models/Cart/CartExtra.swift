//
//  CartExtra.swift
//  deliApp
//
//  Created by iJPe on 10/04/20.
//  Copyright © 2020 reliae. All rights reserved.
//

import UIKit
import CoreData

class CartExtra {
    var storePaymentMethod: PaymentMethod = PaymentMethod()
    var deliveryCost: Double = 0.0
    var addressName: String = ""
    
    func checkIfAddressIsFavorite() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let fetchedResults: NSFetchedResultsController<NSFetchRequestResult>!
        let fetchRequest = NSFetchRequest<CardModel>(entityName: "AddressModel")
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "id", ascending: true)]
        
        fetchedResults = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil) as? NSFetchedResultsController<NSFetchRequestResult>
        
        do {
            try fetchedResults.performFetch()
            
            for aModel in fetchedResults.fetchedObjects! as! [AddressModel] {
                if aModel.address == Identity.shared.cart.data?.addressText {
                    addressName = aModel.label!
                }
            }
        } catch {
            logger.error("Failed to fetch entities: \(error)")
        }
    }
}
