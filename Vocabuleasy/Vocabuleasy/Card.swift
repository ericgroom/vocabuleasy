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
    func associatedCards() -> [Card]? {
        return self.data?.cards?.allObjects as? [Card]
    }
}
