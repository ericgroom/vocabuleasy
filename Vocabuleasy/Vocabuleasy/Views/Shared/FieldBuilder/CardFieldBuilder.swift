//
//  CardFields.swift
//  Vocabuleasy
//
//  Created by Eric Groom on 4/20/19.
//  Copyright © 2019 Eric Groom. All rights reserved.
//

import UIKit

class CardFieldBuilder {
    var fields: [UIView] = []
    
    func addField(view: UIView) -> CardFieldBuilder {
        fields.append(view)
        return self
    }
    
    func build() -> CardFieldSet {
        return fields
    }
}

typealias CardFieldSet = [UIView]

struct CardFields {
    let frontFields: CardFieldSet
    let backFields: CardFieldSet
}
