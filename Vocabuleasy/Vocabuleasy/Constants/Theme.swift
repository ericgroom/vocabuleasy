//
//  Theme.swift
//  Vocabuleasy
//
//  Created by Eric Groom on 4/18/19.
//  Copyright © 2019 Eric Groom. All rights reserved.
//

import UIKit

struct Theme {
    static let green = UIColor.sketch(h: 157, s: 62, b: 60)
    static let purple = UIColor.sketch(h: 278, s: 86, b: 81)
    static let darkGray = UIColor.sketch(h: 0, s: 0, b: 13)
    static let white = UIColor.sketch(h: 0, s: 0, b: 95)
    
    static let iosBlue = UIColor(red: 0, green: 122.0/255.0, blue: 1, alpha: 1.0)
    
    struct Ratings {
        static let good = UIColor.sketch(h: 130, s: 65, b: 85)
        static let warning = UIColor.sketch(h: 48, s: 100, b: 100)
        static let bad = UIColor.sketch(h: 3, s: 81, b: 100)
    }
    
    struct Fonts {
        static let largeWord = UIFont(descriptor: .preferredFontDescriptor(withTextStyle: .largeTitle), size: 32)
        static let bold = UIFont(descriptor: .preferredFontDescriptor(withTextStyle: .headline), size: 18)
    }
}
