//
//  Deck.swift
//  Vocabuleasy
//
//  Created by Eric Groom on 5/4/19.
//  Copyright © 2019 Eric Groom. All rights reserved.
//

import Foundation
import CoreData

@objc(Deck)
class Deck: NSManagedObject {

    func generateReviewSession(cards: [Card]) -> ReviewSession {
        return ReviewSession(cards: cards)
    }
    
    func allCards() -> NSFetchRequest<Card> {
        let request: NSFetchRequest<Card> = Card.fetchRequest()
        let sortDate = NSSortDescriptor(key: "nextReview", ascending: true)
        request.sortDescriptors = [sortDate]
        request.predicate = NSPredicate(format: "deck == %@", self)
        return request
    }
    
    func whereNeedsReview() -> NSFetchRequest<Card> {
        let request: NSFetchRequest<Card> = Card.fetchRequest()
        let predicate = NSPredicate(format: "nextReview < %@ && deck == %@", NSDate(), self)
        let sortDate = NSSortDescriptor(key: "nextReview", ascending: true)
        request.predicate = predicate
        request.sortDescriptors = [sortDate]
        return request
    }
}
