//
//  Card.swift
//  Vocabuleasy
//
//  Created by Eric Groom on 5/4/19.
//  Copyright © 2019 Eric Groom. All rights reserved.
//

import Foundation
import CoreData

@objc(Card)
class Card: NSManagedObject {
    static func fetchCardsToReview() -> NSFetchRequest<Card> {
        let request: NSFetchRequest<Card> = self.fetchRequest()
        let predicate = NSPredicate(format: "nextReview < %@", NSDate())
        let sortDate = NSSortDescriptor(key: "nextReview", ascending: true)
        request.predicate = predicate
        request.sortDescriptors = [sortDate]
        return request
    }
}

//extension Card: Hashable {
//    static func == (lhs: Card, rhs: Card) -> Bool {
//        return lhs.id == rhs.id
//    }
//
//    func hash(into hasher: inout Hasher) {
//        hasher.combine(id)
//    }
//}
