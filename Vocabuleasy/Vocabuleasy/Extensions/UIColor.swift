//
//  UIColor.swift
//  Vocabuleasy
//
//  Created by Eric Groom on 4/18/19.
//  Copyright © 2019 Eric Groom. All rights reserved.
//

import UIKit

extension UIColor {
    /**
     * Factory for UIColor for converting Sketch HSB to UIColor HSB ranges.
     *
     * - Parameter h: `0-360` inc. (hue)
     * - Parameter s: `0-100` inc.  (saturation)
     * - Parameter b: `0-100` inc. (brightness)
     * - Parameter a: `0.0-1.0` inc. (alpha)
    */
    static func sketch(h: CGFloat, s: CGFloat, b: CGFloat, a: CGFloat = 1.0) -> UIColor {
        return UIColor(hue: h/360.0, saturation: s/100.0, brightness: b/100.0, alpha: a)
    }
}
