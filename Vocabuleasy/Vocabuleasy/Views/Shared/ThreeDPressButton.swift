//
//  RatingButton.swift
//  Vocabuleasy
//
//  Created by Eric Groom on 4/23/19.
//  Copyright © 2019 Eric Groom. All rights reserved.
//

import UIKit

class ThreeDPressButton: UIButton {

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
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                layer.borderColor = UIColor.white.cgColor
                layer.borderWidth = 2.0
            } else {
                layer.borderColor = UIColor.clear.cgColor
                layer.borderWidth = 0.0
            }
        }
    }
    
    private func press() {
        guard let transform = pressTransform else { return }
        self.transform = transform
        self.layer.shadowOpacity = 0.0
    }
    
    private func depress() {
        self.transform = CGAffineTransform.identity
        self.layer.shadowOpacity = 1.0
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        if isEnabled && isTouchInside {
            press()
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        depress()
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        depress()
    }
}
