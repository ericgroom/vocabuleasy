//
//  ShakeAnimationController.swift
//  Vocabuleasy
//
//  Created by Eric Groom on 4/20/19.
//  Copyright © 2019 Eric Groom. All rights reserved.
//

import UIKit

class ShakeAnimationController {
    
    private init() {}
    
    static func shake(_ view: UIView, maxAngleInRadians maxAngle: CGFloat, duration: TimeInterval) {
        let shakeDuration: TimeInterval = 0.2
        var multiplier: CGFloat = 1
        var lastKeyFrameEndpoint: TimeInterval = 0.0
        UIView.animateKeyframes(withDuration: duration, delay: 0, options: [], animations: {
            for i in stride(from: 0, to: duration-shakeDuration, by: shakeDuration) {
                UIView.addKeyframe(withRelativeStartTime: i, relativeDuration: shakeDuration, animations: {
                    view.transform = CGAffineTransform(rotationAngle: maxAngle*multiplier)
                })
                multiplier *= -1
                lastKeyFrameEndpoint = i+shakeDuration
            }
            UIView.addKeyframe(withRelativeStartTime: lastKeyFrameEndpoint, relativeDuration: shakeDuration, animations: {
                view.transform = CGAffineTransform(rotationAngle: 0)
            })
        })
    }
}
