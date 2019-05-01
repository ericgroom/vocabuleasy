//
//  DeckDetailViewController.swift
//  Vocabuleasy
//
//  Created by Eric Groom on 4/27/19.
//  Copyright © 2019 Eric Groom. All rights reserved.
//

import UIKit

class DeckDetailViewController: UIViewController {
    
    private let reviewButton: UIButton = {
        let button = UIButton()
        ButtonStyler.flat(button, foreground: Theme.white, background: Theme.purple)
        button.setTitle("Review", for: .normal)
        button.addTarget(self, action: #selector(reviewButtonPressed), for: .touchUpInside)
        return button
    }()
    
    private let addButton: UIButton = {
        let button = UIButton()
        ButtonStyler.outline(button, foreground: Theme.purple)
        button.setTitle("Add New", for: .normal)
        return button
    }()
    
    private let card = CardBackgroundView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Theme.green
        navigationItem.title = "Deck Detail" // TODO update with deck name
        setupNavbar()
        
        view.addSubview(card)
        card.center(on: view)
        card.leading(to: view.leadingAnchor, withOffset: Layout.Spacing.standard)
        card.trailing(to: view.trailingAnchor, withOffset: Layout.Spacing.standard)
        card.hero.id = "cardBackground"
        
        card.addArrangedSubview(reviewButton)
        reviewButton.width(to: card, withOffset: -Layout.Spacing.standard*2)
        card.addArrangedSubview(addButton)
        addButton.width(to: card, withOffset: -Layout.Spacing.standard*2)
    }
    
    @objc func reviewButtonPressed() {
        let reviewVC = ReviewViewController()
        navigationController?.pushViewController(reviewVC, animated: true)
    }
    
    private func setupNavbar() {
        NavigationStyler.applyTheme(to: navigationController)
    }

    

}
