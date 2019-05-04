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
    
    func generateReviewSession() -> ReviewSession {
        return ReviewSession(cards: cards)
    }
    
    static func mockDeck() -> Deck {
        let first = Card(front: "testing", back: "the thing")
        let second = Card(front: "Naming things", back: "is hard")
        let third = Card(front: "target language", back: "definition")
        let fourth = Card(front: "y u no work", back: ":(")
        return Deck(cards: [first, second, third, fourth])
    }
}
