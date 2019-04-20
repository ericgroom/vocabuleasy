//
//  UIViewController.swift
//  Vocabuleasy
//
//  Created by Eric Groom on 4/20/19.
//  Copyright © 2019 Eric Groom. All rights reserved.
//

import UIKit

extension UIViewController {
    func embed(_ viewController: UIViewController) {
        addChild(viewController)
        view.addSubview(viewController.view)
    }
}
