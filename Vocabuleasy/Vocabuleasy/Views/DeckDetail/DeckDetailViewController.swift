//
//  DeckDetailViewController.swift
//  Vocabuleasy
//
//  Created by Eric Groom on 4/27/19.
//  Copyright © 2019 Eric Groom. All rights reserved.
//

import UIKit

class DeckDetailViewController: UIViewController {
    
    var deck: Deck? {
        didSet {
            deckInfoVC.deck = deck
        }
    }
    
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
    
    private let settingsButton: UIButton = {
        let button = UIButton()
        ButtonStyler.outline(button, foreground: Theme.purple)
        button.setTitle("Settings", for: .normal)
        button.addTarget(self, action: #selector(settingsButtonPressed), for: .touchUpInside)
        return button
    }()
    
    private let card = CardBackgroundView()
    private let deckInfoVC = DeckInfoViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Theme.green
        navigationItem.title = deck?.name
        
        view.addSubview(card)
        card.center(on: view)
        card.leading(to: view.leadingAnchor, withOffset: Layout.Spacing.standard)
        card.trailing(to: view.trailingAnchor, withOffset: Layout.Spacing.standard)
        card.hero.id = "cardBackground"
        
        card.addArrangedSubview(reviewButton)
        reviewButton.width(to: card, withOffset: -Layout.Spacing.standard*2)
        card.addArrangedSubview(addButton)
        addButton.width(to: card, withOffset: -Layout.Spacing.standard*2)
        card.addArrangedSubview(settingsButton)
        settingsButton.width(to: card, withOffset: -Layout.Spacing.standard*2)
        
        embed(deckInfoVC)
        deckInfoVC.view.bottom(to: card.topAnchor, withOffset: Layout.Spacing.standard)
        deckInfoVC.view.center(on: view, axis: .x)
    }
    
    @objc func reviewButtonPressed() {
        guard let deck = deck else { return }
        let context = ContainerService.shared.persistentContainer.viewContext
        let request = deck.whereNeedsReview()
        request.fetchLimit = 5
        do {
            let cards = try context.fetch(request)
            let reviewVC = ReviewViewController()
            reviewVC.reviewSession = deck.generateReviewSession(cards: cards)
            reviewVC.deck = deck
            navigationController?.pushViewController(reviewVC, animated: true)
        } catch {
            NotificationService.showErrorBanner(withText: "Error fetching cards")
        }
    }
    
    @objc func addNewButtonPressed() {
        guard let deck = deck else { return }
        let addNewVc = AddCardViewController()
        addNewVc.mode = .add
        addNewVc.deck = deck
        navigationController?.pushViewController(addNewVc, animated: true)
    }
    
    @objc func settingsButtonPressed() {
        guard let deck = deck else { return }
        let settingsVC = DeckSettingsViewController()
        settingsVC.deck = deck
        navigationController?.pushViewController(settingsVC, animated: true)
    }
}
