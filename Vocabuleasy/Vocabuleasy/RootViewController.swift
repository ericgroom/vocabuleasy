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
        setupNavbar()
        navigationController?.pushViewController(reviewVC, animated: false)
    }
    
    func setupNavbar() {
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.barTintColor = Theme.green
        navigationController?.navigationBar.tintColor = Theme.white
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: Theme.white]
    }
}
