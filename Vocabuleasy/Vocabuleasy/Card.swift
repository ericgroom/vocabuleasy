//
//  Card.swift
//  Vocabuleasy
//
//  Created by Eric Groom on 5/4/19.
//  Copyright © 2019 Eric Groom. All rights reserved.
//

import Foundation

class Card {
    let id: UUID
    var front: String
    var back: String
    var timesCorrect: Int = 0
    var lastReviewed: Date? = nil
    var nextReview: Date? = nil
    
    convenience init(front: String, back: String) {
        self.init(id: UUID(), front: front, back: back)
    }
    
    init(id: UUID, front: String, back: String) {
        self.front = front
        self.back = back
        self.id = id
    }
}

extension Card: Hashable, Equatable {
    static func == (lhs: Card, rhs: Card) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
