//
//  Symbol.swift
//  Vocabuleasy
//
//  Created by Eric Groom on 4/23/19.
//  Copyright © 2019 Eric Groom. All rights reserved.
//

import UIKit

protocol SymbolView where Self: UIView {
    var lineWidth: CGFloat { get set}
    var color: UIColor { get set}
}

struct SymbolViewConstants {
    static let defaultLineWidth: CGFloat = 10.0
    static let defaultColor: UIColor = .white
}
