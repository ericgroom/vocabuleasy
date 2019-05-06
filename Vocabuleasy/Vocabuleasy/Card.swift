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
    static func all() -> NSFetchRequest<Card> {
        let request: NSFetchRequest<Card> = self.fetchRequest()
        let sortDate = NSSortDescriptor(key: "nextReview", ascending: true)
        request.sortDescriptors = [sortDate]
        return request
    }
    
    static func whereNeedsReview() -> NSFetchRequest<Card> {
        let request: NSFetchRequest<Card> = self.fetchRequest()
        let predicate = NSPredicate(format: "nextReview < %@", NSDate())
        let sortDate = NSSortDescriptor(key: "nextReview", ascending: true)
        request.predicate = predicate
        request.sortDescriptors = [sortDate]
        return request
    }
}
