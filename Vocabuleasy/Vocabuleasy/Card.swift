//
//  Card.swift
//  Vocabuleasy
//
//  Created by Eric Groom on 5/4/19.
//  Copyright © 2019 Eric Groom. All rights reserved.
//

import Foundation

class Card {
    var front: String
    var back: String
    var timesCorrect: Int = 0
    var lastReviewed: Date? = nil
    
    init(front: String, back: String) {
        self.front = front
        self.back = back
    }
}
