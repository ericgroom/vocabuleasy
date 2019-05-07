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
    
    func getRatingCount() -> [Rating: Int] {
        let cardRatingMap = getFirstRatings()
        var ratingCount = [Rating: Int]()
        // ensure that all ratings are present in map
        Rating.allCases.forEach { ratingCount[$0] = 0 }
        cardRatingMap.values.forEach { ratingCount[$0, default: 0] += 1 }
        return ratingCount
    }
    
    func getFirstRatings() -> [Card: Rating] {
        let cardRatingsMap = getCardRatings()
        return cardRatingsMap.compactMapValues { $0.first }
    }
    
    func getCardRatings() -> [Card: [Rating]] {
        var map = [Card: [Rating]]()
        for card in cardsReviewed {
            map[card.card, default: [Rating]()].append(card.rating)
        }
        return map
    }
}
