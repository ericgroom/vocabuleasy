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
    
    var enabledShadowColor: UIColor? {
        didSet {
            guard let shadowColor = enabledShadowColor else { return }
            if isEnabled {
                layer.shadowColor = shadowColor.cgColor
            }
        }
    }
    var disabledShadowColor: UIColor? {
        didSet {
            guard let shadowColor = disabledShadowColor else { return }
            if !isEnabled {
                layer.shadowColor = shadowColor.cgColor
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
            
            if let disabledColor = disabledShadowColor, !isEnabled {
                layer.shadowColor = disabledColor.cgColor
            } else {
                layer.shadowColor = enabledShadowColor?.cgColor
            }
        }
    }
    
    var pressTransform: CGAffineTransform?
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        if isEnabled && isTouchInside, let transform = pressTransform {
            self.transform = transform
            self.layer.shadowOpacity = 0.0
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        self.transform = CGAffineTransform.identity
        self.layer.shadowOpacity = 1.0
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        self.transform = CGAffineTransform.identity
        self.layer.shadowOpacity = 1.0
    }
}
