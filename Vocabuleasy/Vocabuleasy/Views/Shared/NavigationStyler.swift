//
//  NavigationStyler.swift
//  Vocabuleasy
//
//  Created by Eric Groom on 4/27/19.
//  Copyright © 2019 Eric Groom. All rights reserved.
//

import UIKit

class NavigationStyler {
    private init() {}
    
    static func applyTheme(to navigationController: UINavigationController?) {
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.barTintColor = Theme.green
        navigationController?.navigationBar.tintColor = Theme.white
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: Theme.white]
    }
}
