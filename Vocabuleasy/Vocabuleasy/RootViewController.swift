//
//  RootViewController.swift
//  Vocabuleasy
//
//  Created by Eric Groom on 4/18/19.
//  Copyright © 2019 Eric Groom. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {
    
    var reviewVC = ReviewViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Theme.green
        embed(reviewVC)
        reviewVC.view.fill(parent: view)
    }
}
