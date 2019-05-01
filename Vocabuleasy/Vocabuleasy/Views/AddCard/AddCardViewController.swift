//
//  AddCardViewController.swift
//  Vocabuleasy
//
//  Created by Eric Groom on 4/27/19.
//  Copyright © 2019 Eric Groom. All rights reserved.
//

import UIKit

class AddCardViewController: UIViewController {

    private let card = CardBackgroundView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(card)
        card.fill(parent: view)
    }

}
