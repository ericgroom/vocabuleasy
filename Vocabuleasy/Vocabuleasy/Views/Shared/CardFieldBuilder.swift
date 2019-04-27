//
//  CardFields.swift
//  Vocabuleasy
//
//  Created by Eric Groom on 4/20/19.
//  Copyright © 2019 Eric Groom. All rights reserved.
//

import UIKit

class CardFieldBuilder {
    var front: [UIView] = []
    var back: [UIView] = []
    
    func addFront(view: UIView) -> CardFieldBuilder {
        front.append(view)
        return self
    }
    
    func addBack(view: UIView) -> CardFieldBuilder {
        back.append(view)
        return self
    }
    
    func build() -> CardFields {
        return CardFields(frontFields: front, backFields: back)
    }
}

struct CardFields {
    let frontFields: [UIView]
    let backFields: [UIView]
}
