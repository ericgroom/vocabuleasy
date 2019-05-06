//
//  DeckDetailViewController.swift
//  Vocabuleasy
//
//  Created by Eric Groom on 4/27/19.
//  Copyright © 2019 Eric Groom. All rights reserved.
//

import UIKit

class DeckDetailViewController: UIViewController {
    
    var deck: Deck?
    
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
        button.addTarget(self, action: #selector(addNewButtonPressed), for: .touchUpInside)
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
        reviewVC.reviewSession = deck?.generateReviewSession()
        navigationController?.pushViewController(reviewVC, animated: true)
    }
    
    @objc func addNewButtonPressed() {
        let addNewVc = AddCardViewController()
        addNewVc.delegate = self
        navigationController?.pushViewController(addNewVc, animated: true)
    }
    
    private func setupNavbar() {
        NavigationStyler.applyTheme(to: navigationController)
    }
}

extension DeckDetailViewController: AddCardDelegate {
    func addCard(withFrontText frontText: String?, andBackText backText: String?) {
        let context = ContainerService.shared.persistentContainer.viewContext
        var card = Card(context: context)
        card.front = frontText
        card.back = backText
        
        deck?.addCard(card: card)
    }
}
