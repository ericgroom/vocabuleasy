//
//  ReviewSession.swift
//  Vocabuleasy
//
//  Created by Eric Groom on 5/4/19.
//  Copyright © 2019 Eric Groom. All rights reserved.
//

import Foundation

class ReviewSession {
    private(set) var cards: [Card]
    private(set) var currentIndex: Int {
        didSet {
            print(currentIndex)
        }
    }
    
    init(cards: [Card], startAt index: Int = 0) {
        self.cards = cards
        self.currentIndex = index
    }
    
    var count: Int {
        return cards.count
    }
    
    func cardRated(atIndex index: Int, withRating rating: Rating) {
        let card = cards[index]
        print("card: \(card) given rating: \(rating)")
    }
    
    func get(atIndex index: Int) -> Card? {
        if index >= 0 && index < count {
            return cards[index]
        } else {
            return nil
        }
    }
    
    var canAdvance: Bool {
        return currentIndex+1 < count
    }
    
    func advance() -> Card? {
        if canAdvance {
            currentIndex += 1
            return get(atIndex: currentIndex)
        }
        return nil
    }
    
    var canGoBack: Bool {
        return currentIndex-1 >= 0
    }
    
    func previousCard() -> Card? {
        if canGoBack {
            currentIndex -= 1
            return get(atIndex: currentIndex)
        }
        return nil
    }
}
