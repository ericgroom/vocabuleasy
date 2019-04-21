//
//  ReviewViewController.swift
//  Vocabuleasy
//
//  Created by Eric Groom on 4/18/19.
//  Copyright © 2019 Eric Groom. All rights reserved.
//

import UIKit

class ReviewViewController: UIViewController {
    
    private var cardController = ReviewDeckController()

    private lazy var flipButton: UIButton = makeButton("flip", #selector(flipButtonPressed))
    private lazy var nextButton: UIButton = makeButton("next", #selector(nextButtonPressed))
    private lazy var prevButton: UIButton = makeButton("previous", #selector(prevButtonPressed))


    private func makeButton(_ title: String, _ selector: Selector) -> UIButton {
        let button = UIButton()
        button.setTitle(title, for: .normal)
        button.backgroundColor = Theme.purple
        button.tintColor = .white
        button.layer.cornerRadius = 8.0
        button.contentEdgeInsets = UIEdgeInsets(top: 20, left: 0, bottom: 20, right: 0)
        button.addTarget(self, action: selector, for: .touchUpInside)
        return button
    }
    
    private var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = Layout.Spacing.small
        return stackView
    }()
    
    @objc func flipButtonPressed() {
        cardController.flipCurrentCard()
    }
    
    @objc func nextButtonPressed() {
        cardController.nextCard()
    }
    
    @objc func prevButtonPressed() {
        cardController.previousCard()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Theme.green
        
        embed(cardController)
        view.addSubview(stackView)
        stackView.addArrangedSubview(flipButton)
        stackView.addArrangedSubview(nextButton)
        stackView.addArrangedSubview(prevButton)
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
        
        let buttonWidthRegular = stackView.width(to: cardController.view, activate: false)
        let buttonTopRegular = stackView.top(to: cardController.view.bottomAnchor, withOffset: Layout.Spacing.standard, activate: false)
        let buttonCenter = stackView.center(on: view, axis: .x, activate: false)
        regularConstraints = [cardTopRegular, cardTrailingRegular, buttonTopRegular, buttonWidthRegular]
        regularConstraints.append(contentsOf: buttonCenter)
        
        // compact constraints
        let cardTopCompact = cardController.view.top(to: view.topAnchor, withOffset: Layout.Spacing.standard, activate: false)
        let cardTrailingCompact = cardController.view.trailing(to: stackView.leadingAnchor, withOffset: Layout.Spacing.standard, activate: false)
        let cardBottomCompact = cardController.view.bottom(to: view.bottomAnchor, withOffset: Layout.Spacing.standard, activate: false)
        
        let buttonCenterCompact = stackView.center(on: view, axis: .y, activate: false)
        let buttonLeadingCompact = stackView.leading(to: cardController.view.trailingAnchor, withOffset: Layout.Spacing.standard, activate: false)
        let buttonTrailingCompact = stackView.trailing(to: view.trailingAnchor, withOffset: Layout.Spacing.standard, activate: false)
        
        compactConstraints = [cardTopCompact, cardTrailingCompact, cardBottomCompact, buttonLeadingCompact, buttonTrailingCompact]
        compactConstraints.append(contentsOf: buttonCenterCompact)
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        if let previous = previousTraitCollection, previous.verticalSizeClass == traitCollection.verticalSizeClass {
            return
        }
        
        if traitCollection.verticalSizeClass == .compact && previousTraitCollection?.verticalSizeClass != .compact {
            NSLayoutConstraint.deactivate(regularConstraints)
            NSLayoutConstraint.activate(compactConstraints)
        } else {
            NSLayoutConstraint.deactivate(compactConstraints)
            NSLayoutConstraint.activate(regularConstraints)
        }
        view.layoutIfNeeded()
    }
}
