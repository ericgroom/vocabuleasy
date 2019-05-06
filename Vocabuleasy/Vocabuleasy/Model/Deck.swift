//
//  Deck.swift
//  Vocabuleasy
//
//  Created by Eric Groom on 5/4/19.
//  Copyright © 2019 Eric Groom. All rights reserved.
//

import Foundation

class Deck {
    private(set) var cards: [Card]
    
    init(cards: [Card] = []) {
        self.cards = cards
    }
    
    var cardsToReview: Int {
        return cards.count
    }
    
    func addCard(card: Card) {
        self.cards.append(card)
    }
    
    func generateReviewSession(cards: [Card]) -> ReviewSession {
        return ReviewSession(cards: cards)
    }
}
