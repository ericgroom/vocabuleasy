//
//  PaddedTextField.swift
//  Vocabuleasy
//
//  Created by Eric Groom on 5/1/19.
//  Copyright © 2019 Eric Groom. All rights reserved.
//

import UIKit

class PaddedTextField: UITextField {
    var textInsets: UIEdgeInsets? {
        didSet {
            setNeedsLayout()
        }
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        if let insets = textInsets {
            return bounds.inset(by: insets)
        } else {
            return super.textRect(forBounds: bounds)
        }
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        if let insets = textInsets {
            return bounds.inset(by: insets)
        } else {
            return super.editingRect(forBounds: bounds)
        }
    }

}
