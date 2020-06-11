//
//  CardsResponse.swift
//  deliApp
//
//  Created by iJPe on 26/02/20.
//  Copyright © 2020 reliae. All rights reserved.
//

class CardsResponse: Codable {
    var success: Int?
    var cards: [Card]?
    var message: String?
    
    init(success: Int?, cards: [Card]?, message: String?) {
        self.success = success
        self.cards = cards
        self.message = message
    }
}
