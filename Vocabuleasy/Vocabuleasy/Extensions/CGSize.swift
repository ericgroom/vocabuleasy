//
//  CGSize.swift
//  Vocabuleasy
//
//  Created by Eric Groom on 5/11/19.
//  Copyright © 2019 Eric Groom. All rights reserved.
//

import UIKit

extension CGSize {
    var aspectRatio: CGFloat {
        return self.width / self.height
    }
}
