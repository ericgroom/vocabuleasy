//
//  ReviewViewController.swift
//  Vocabuleasy
//
//  Created by Eric Groom on 4/18/19.
//  Copyright © 2019 Eric Groom. All rights reserved.
//

import UIKit

class ReviewViewController: UIViewController {
    
    let cardController = CardViewController()
    var card: UIView { return self.cardController.view }
    let flipButton: UIButton = {
        let button = UIButton()
        button.setTitle("flip", for: .normal)
        button.backgroundColor = Theme.purple
        button.layer.cornerRadius = 8.0
        button.addTarget(self, action: #selector(flipButtonPressed), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        addChild(cardController)
        
        view.addSubview(card)
        view.addSubview(flipButton)
        
        card.center(on: view, axis: .x)
        card.top(to: view.topAnchor, withOffset: 64.0)
        card.width(.equal, to: 300)
        card.height(.equal, to: 300)
        
        flipButton.top(to: card.bottomAnchor, withOffset: 32.0)
        flipButton.center(on: view, axis: .x)
        flipButton.width(to: card)
    }
    
    @objc func flipButtonPressed() {
        cardController.flipCard()
    }

}
