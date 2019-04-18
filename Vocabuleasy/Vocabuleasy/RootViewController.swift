//
//  RootViewController.swift
//  Vocabuleasy
//
//  Created by Eric Groom on 4/18/19.
//  Copyright © 2019 Eric Groom. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {
    
    let reviewVC = ReviewViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
        addChild(reviewVC)
        view.addSubview(reviewVC.view)
        reviewVC.view.fill(parent: view)
    }

}
