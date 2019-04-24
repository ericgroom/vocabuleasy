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
    
    var enabledBackgroundColor: UIColor? {
        didSet {
            if isEnabled {
                backgroundColor = enabledBackgroundColor
            }
        }
    }
    
    var disabledBackgroundColor: UIColor? {
        didSet {
            if !isEnabled {
                backgroundColor = disabledBackgroundColor
            }
        }
    }
    
    var enabledShadowColor: UIColor? {
        didSet {
            if isEnabled {
                layer.shadowColor = enabledShadowColor?.cgColor
            }
        }
    }
    var disabledShadowColor: UIColor? {
        didSet {
            if !isEnabled {
                layer.shadowColor = disabledShadowColor?.cgColor
            }
        }
    }
    
    override var isEnabled: Bool {
        didSet {
            let enabled = isEnabled
            UIView.animate(withDuration: 0.15) { [weak self] in
                guard let self = self else { return }
                if enabled {
                    self.backgroundColor = self.enabledBackgroundColor
                    self.layer.shadowColor = self.enabledShadowColor?.cgColor
                } else {
                    self.backgroundColor = self.disabledBackgroundColor
                    self.layer.shadowColor = self.disabledShadowColor?.cgColor
                }
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
