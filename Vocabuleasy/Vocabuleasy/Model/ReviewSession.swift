//
//  ReviewSession.swift
//  Vocabuleasy
//
//  Created by Eric Groom on 5/4/19.
//  Copyright © 2019 Eric Groom. All rights reserved.
//

import Foundation

typealias CardWithRating = (card: Card, rating: Rating?)


class ReviewSession {

    private(set) var currentIndex: Int
    private(set) var cards: [CardWithRating]
    
    init(cards: [Card], startAt index: Int = 0) {
        self.cards = cards.map { (card: $0, rating: nil) }
        self.currentIndex = index
    }
    
    var count: Int {
        return cards.count
    }
    
    var currentCard: CardWithRating? {
        return get(atIndex: currentIndex)
    }
    
    func cardRated(withRating rating: Rating) {
        self.cardRated(atIndex: currentIndex, withRating: rating)
    }
    
    func cardRated(atIndex index: Int, withRating rating: Rating) {
        let card = cards[index]
        if rating == .wrong {
            cards.append(card)
        }
        cards[index].rating = rating
    }
    
    func get(atIndex index: Int) -> CardWithRating? {
        if index >= cards.startIndex && index < cards.endIndex {
            return cards[index]
        } else {
            return nil
        }
    }
    
    var canAdvance: Bool {
        return currentIndex+1 < cards.endIndex && currentCard?.rating != nil
    }
    
    func advance() -> CardWithRating? {
        if canAdvance {
            currentIndex += 1
            return get(atIndex: currentIndex)
        }
        return nil
    }
    
    var canGoBack: Bool {
        return currentIndex-1 >= cards.startIndex
    }
    
    
    func goBack() -> CardWithRating? {
        if canGoBack {
            currentIndex -= 1
            return get(atIndex: currentIndex)
        }
        return nil
    }
    
    var isCompleted: Bool {
        return cards.isEmpty || (currentIndex >= cards.endIndex-1 && currentCard?.rating != nil)
    }
    
    func complete() -> ReviewSessionLog {
        return ReviewSessionLog(of: self)
    }
}
