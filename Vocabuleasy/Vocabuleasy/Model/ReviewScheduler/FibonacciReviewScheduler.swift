//
//  FibonacciReviewScheduler.swift
//  Vocabuleasy
//
//  Created by Eric Groom on 5/12/19.
//  Copyright © 2019 Eric Groom. All rights reserved.
//

import Foundation

/// SRS algorithm using fibonacci sequence
class FibonacciReviewScheduler: ReviewScheduler {
    var baseIntervalInMinutes: Int
    
    init(baseInterval minutes: Int) {
        self.baseIntervalInMinutes = minutes
    }
    
    private func fib(of index: Int) -> Int {
        if index < 1 {
            return index
        }
        var a = 0
        var b = 1
        // traditinally the fib sequence goes 0, 1, 1, 2... `0...index` instead of `0..<index` offsets it by 1 so that index 1 and 2 don't return `1` as that doesn't make much sense business logic wise.
        for _ in 0...index {
            let temp = a+b
            a = b
            b = temp
        }
        return a
    }
    
    func schedule(session: ReviewSessionLog) {
        let firstRatings = session.getFirstRatings()
        for (card, rating) in firstRatings {
            switch rating {
            case .correct:
                card.timesCorrect += 1
                let deltaMinutes = fib(of: Int(card.timesCorrect)) * baseIntervalInMinutes
                self.setNextReview(for: card, in: deltaMinutes)
            case .meh:
                card.timesCorrect += 1
                let deltaMinutes = fib(of: Int(card.timesCorrect)) * baseIntervalInMinutes / 2
                self.setNextReview(for: card, in: deltaMinutes)
            case .wrong:
                card.timesCorrect = 0
                self.setNextReview(for: card, in: baseIntervalInMinutes/2)
            }
        }
    }
}
