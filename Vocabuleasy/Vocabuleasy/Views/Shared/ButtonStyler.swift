//
//  ButtonStyler.swift
//  Vocabuleasy
//
//  Created by Eric Groom on 4/27/19.
//  Copyright © 2019 Eric Groom. All rights reserved.
//

import UIKit

class ButtonStyler {
    private init() {}
    
    static func flat(_ button: UIButton, foreground: UIColor, background: UIColor) {
        button.backgroundColor = background
        button.setTitleColor(foreground, for: .normal)
        button.layer.cornerRadius = 8.0
        button.contentEdgeInsets = UIEdgeInsets(top: 20, left: 0, bottom: 20, right: 0)
    }
    
    static func outline(_ button: UIButton, foreground: UIColor) {
        button.backgroundColor = .clear
        button.setTitleColor(foreground, for: .normal)
        button.layer.borderColor = foreground.cgColor
        button.layer.borderWidth = 2.0
        button.layer.cornerRadius = 8.0
        button.contentEdgeInsets = UIEdgeInsets(top: 20, left: 0, bottom: 20, right: 0)
    }
}
