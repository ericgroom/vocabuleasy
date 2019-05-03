//
//  KeyboardViewController.swift
//  Vocabuleasy
//
//  Created by Eric Groom on 5/2/19.
//  Copyright © 2019 Eric Groom. All rights reserved.
//

import UIKit

class KeyboardViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let dismissGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        dismissGesture.numberOfTapsRequired = 1
        view.addGestureRecognizer(dismissGesture)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }

}
