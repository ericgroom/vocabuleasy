//
//  ShortReviewScheduler.swift
//  Vocabuleasy
//
//  Created by Eric Groom on 5/4/19.
//  Copyright © 2019 Eric Groom. All rights reserved.
//

import Foundation

class ShortReviewScheduler: ReviewScheduler {
    
    func schedule(session: ReviewSessionLog) {
        // get initial rating of card
        var cardMap: [Card: Rating] = [:]
        for card in session.cardsReviewed {
            if !cardMap.keys.contains(card.card) {
                cardMap[card.card] = card.rating
            }
        }
        for (card, rating) in cardMap {
            schedule(card: card, wasRated: rating)
        }
    }
    
    private func schedule(card: Card, wasRated rating: Rating) {
        let minutes: Int
        switch rating {
        case .correct:
            minutes = 5
        case .meh:
           minutes = 2
        case .wrong:
            minutes = 1
        }
        let now = Date()
        card.lastReviewed = now
        var components = DateComponents()
        components.minute = minutes
        let nextDate = Calendar.autoupdatingCurrent.date(byAdding: components, to: now)
        card.nextReview = nextDate
    }
}
