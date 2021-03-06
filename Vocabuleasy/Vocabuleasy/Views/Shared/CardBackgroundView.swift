//
//  CardBackgroundView.swift
//  Vocabuleasy
//
//  Created by Eric Groom on 4/18/19.
//  Copyright © 2019 Eric Groom. All rights reserved.
//

import UIKit

class CardBackgroundView: UIView {
    
    let stackView = ScrollableStackView()
    
    func addArrangedSubview(_ view: UIView) {
        stackView.addArrangedSubview(view)
    }
    
    func removeArrangedSubview(_ view: UIView) {
        stackView.removeArrangedSubview(view)
        view.removeFromSuperview()
    }
    
    private func setup() {
        backgroundColor = Theme.white
        self.clipsToBounds = false
        layer.cornerRadius = 8.0
        layer.shadowColor = Theme.darkGray.cgColor
        layer.shadowOffset = CGSize(width: 2, height: 2)
        layer.shadowRadius = 4.0
        layer.shadowOpacity = 0.5
        
        addSubview(stackView)
        stackView.fill(parent: self, withOffset: Layout.Spacing.small)
        
        let delta = 10
        let horizontalMotionEffect = UIInterpolatingMotionEffect(keyPath: "center.x", type: .tiltAlongHorizontalAxis)
        horizontalMotionEffect.minimumRelativeValue = -delta
        horizontalMotionEffect.maximumRelativeValue = delta
        let verticalMotionEffect = UIInterpolatingMotionEffect(keyPath: "center.y", type: .tiltAlongVerticalAxis)
        verticalMotionEffect.minimumRelativeValue = -delta
        verticalMotionEffect.maximumRelativeValue = delta
        
        let effectGroup = UIMotionEffectGroup()
        effectGroup.motionEffects = [horizontalMotionEffect, verticalMotionEffect]
        
        self.addMotionEffect(effectGroup)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
}
