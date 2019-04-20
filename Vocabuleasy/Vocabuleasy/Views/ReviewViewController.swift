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
    
    @objc func flipButtonPressed() {
        cardController.flipCard()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Theme.green
        
        embed(cardController)
        view.addSubview(flipButton)
        
        setupConstraints()
    }
    
    // MARK: - Autolayout
    
    private var regularConstraints: [NSLayoutConstraint] = []
    private var compactConstraints: [NSLayoutConstraint] = []
    
    private func setupConstraints() {
        // universal
        cardController.view.leading(to: view.leadingAnchor, withOffset: Layout.Spacing.standard)
        cardController.view.height(to: cardController.view.widthAnchor, withMultiplier: 1/Layout.goldenRatio)
        
        // regular constraints
        let cardTopRegular = cardController.view.top(to: view.topAnchor, withOffset: 64, activate: false)
        let cardTrailingRegular = cardController.view.trailing(to: view.trailingAnchor, withOffset: Layout.Spacing.standard, activate: false)
        
        let buttonWidthRegular = flipButton.width(to: cardController.view, activate: false)
        let buttonTopRegular = flipButton.top(to: cardController.view.bottomAnchor, withOffset: Layout.Spacing.standard, activate: false)
        let buttonCenter = flipButton.center(on: view, axis: .x, activate: false)
        regularConstraints = [cardTopRegular, cardTrailingRegular, buttonTopRegular, buttonWidthRegular]
        regularConstraints.append(contentsOf: buttonCenter)
        
        // compact constraints
        let cardTopCompact = cardController.view.top(to: view.topAnchor, withOffset: Layout.Spacing.standard, activate: false)
        let cardTrailingCompact = cardController.view.trailing(to: flipButton.leadingAnchor, withOffset: Layout.Spacing.standard, activate: false)
        let cardBottomCompact = cardController.view.bottom(to: view.bottomAnchor, withOffset: Layout.Spacing.standard, activate: false)
        
        let buttonCenterCompact = flipButton.center(on: view, axis: .y, activate: false)
        let buttonLeadingCompact = flipButton.leading(to: cardController.view.trailingAnchor, withOffset: Layout.Spacing.standard, activate: false)
        let buttonTrailingCompact = flipButton.trailing(to: view.trailingAnchor, withOffset: Layout.Spacing.standard, activate: false)
        
        compactConstraints = [cardTopCompact, cardTrailingCompact, cardBottomCompact, buttonLeadingCompact, buttonTrailingCompact]
        compactConstraints.append(contentsOf: buttonCenterCompact)
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        if let previous = previousTraitCollection, previous.verticalSizeClass == traitCollection.verticalSizeClass {
            return
        }
        if traitCollection.verticalSizeClass == .compact && previousTraitCollection?.verticalSizeClass != .compact {
            print("changing constraints")
            NSLayoutConstraint.deactivate(regularConstraints)
            NSLayoutConstraint.activate(compactConstraints)
        } else {
            print("changing constraints")
            NSLayoutConstraint.deactivate(compactConstraints)
            NSLayoutConstraint.activate(regularConstraints)
        }
        view.layoutIfNeeded()
    }
}
