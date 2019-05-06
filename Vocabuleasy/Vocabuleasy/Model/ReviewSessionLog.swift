//
//  ReviewSessionLog.swift
//  Vocabuleasy
//
//  Created by Eric Groom on 5/5/19.
//  Copyright © 2019 Eric Groom. All rights reserved.
//

import Foundation

struct ReviewSessionLog {
    let cardsReviewed: [RatedCard]
    
    init(of reviewSession: ReviewSession) {
        self.cardsReviewed = reviewSession.cards.compactMap { card in
            guard let rating = card.rating else { return nil }
            return RatedCard(card: card.card, rating: rating)
        }
    }
    
    init(with cards: [RatedCard]) {
        self.cardsReviewed = cards
    }
}
