//
//  RatingButton.swift
//  Vocabuleasy
//
//  Created by Eric Groom on 4/23/19.
//  Copyright © 2019 Eric Groom. All rights reserved.
//

import UIKit

class RatingButton: UIButton {

    var symbolImage: UIImage?
    
    override var backgroundColor: UIColor? {
        didSet {
            _backgroundColor = backgroundColor
        }
    }
    private var _backgroundColor: UIColor?
    
    var disabledBackgroundColor: UIColor? {
        didSet {
            if !isEnabled {
                backgroundColor = disabledBackgroundColor
            }
        }
    }
    
    override var isEnabled: Bool {
        didSet {
            if let disabledColor = disabledBackgroundColor, !isEnabled {
                backgroundColor = disabledColor
            } else {
                backgroundColor = _backgroundColor
            }
        }
    }
}
