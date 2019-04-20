//
//  ReviewViewController.swift
//  Vocabuleasy
//
//  Created by Eric Groom on 4/18/19.
//  Copyright © 2019 Eric Groom. All rights reserved.
//

import UIKit

class ReviewViewController: UIViewController {
    
    private var cardController = CardViewController()
    private var flipButton: UIButton = {
        let flipButton = UIButton()
        flipButton.setTitle("flip", for: .normal)
        flipButton.backgroundColor = Theme.purple
        flipButton.tintColor = .white
        flipButton.layer.cornerRadius = 8.0
        flipButton.addTarget(self, action: #selector(flipButtonPressed), for: .touchUpInside)
        return flipButton
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Theme.green
        
        embed(cardController)
        cardController.view.top(to: view.topAnchor, withOffset: 64)
        cardController.view.leading(to: view.leadingAnchor, withOffset: 16)
        cardController.view.trailing(to: view.trailingAnchor, withOffset: 16)
        cardController.view.height(to: cardController.view.widthAnchor, withMultiplier: 1/1.618)
        
        view.addSubview(flipButton)
        flipButton.width(to: cardController.view)
        flipButton.top(to: cardController.view.bottomAnchor, withOffset: 16)
        flipButton.center(on: view, axis: .x)
    }
    
    
    
    @objc func flipButtonPressed() {
        cardController.flipCard()
    }

}
