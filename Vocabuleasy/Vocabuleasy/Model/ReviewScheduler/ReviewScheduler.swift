//
//  ReviewScheduler.swift
//  Vocabuleasy
//
//  Created by Eric Groom on 5/4/19.
//  Copyright © 2019 Eric Groom. All rights reserved.
//

import Foundation

protocol ReviewScheduler {
    func schedule(session: ReviewSessionLog)
}

extension ReviewScheduler {
    func setNextReview(for card: Card, in minutes: Int) {
        let now = Date()
        card.lastReviewed = now
        var components = DateComponents()
        components.minute = minutes
        let nextDate = Calendar.autoupdatingCurrent.date(byAdding: components, to: now)
        card.nextReview = nextDate
    }
}
