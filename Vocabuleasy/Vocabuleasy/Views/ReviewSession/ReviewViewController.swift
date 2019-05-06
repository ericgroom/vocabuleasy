//
//  ReviewViewController.swift
//  Vocabuleasy
//
//  Created by Eric Groom on 4/18/19.
//  Copyright © 2019 Eric Groom. All rights reserved.
//

import UIKit
import NotificationBannerSwift

class ReviewViewController: UIViewController {
    
    var reviewSession: ReviewSession? {
        didSet {
            cardController.reviewSession = reviewSession
        }
    }
    
    private var cardController = ReviewDeckController()
    private var ratingController = ReviewRatingViewController()
    
    private var cardView: UIView { return cardController.view }
    private var controls: UIView { return ratingController.view }
    
    private var cardGestureRecognizer: CardGestureRecognizer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Theme.green
        navigationItem.title = "Review"
        
        hero.isEnabled = true
        
        cardController.delegate = self
        ratingController.delegate = self
        ratingController.disable()
        
        cardGestureRecognizer = CardGestureRecognizer(cardView: cardView)
        cardGestureRecognizer?.delegate = self
        
        embed(cardController)
        embed(ratingController)
        setupConstraints()
        
        cardView.hero.id = "cardBackground"
    }
    
    // MARK: - Autolayout
    
    private var regularConstraints: [NSLayoutConstraint] = []
    private var compactConstraints: [NSLayoutConstraint] = []
    
    private func setupConstraints() {
        // universal
        cardView.leading(to: view.leadingAnchor, withOffset: Layout.Spacing.standard)
        cardView.height(to: cardView.widthAnchor, withMultiplier: 1/Layout.goldenRatio)
        
        // regular constraints
        let cardTopRegular = cardView.top(to: view.topAnchor, withOffset: Layout.Spacing.standard, activate: false)
        let cardTrailingRegular = cardView.trailing(to: view.trailingAnchor, withOffset: Layout.Spacing.standard, activate: false)
        
        let buttonWidthRegular = controls.width(to: cardView, activate: false)
        let buttonTopRegular = controls.top(to: cardView.bottomAnchor, withOffset: Layout.Spacing.standard, activate: false)
        let buttonCenter = controls.center(on: view, axis: .x, activate: false)
        regularConstraints = [cardTopRegular, cardTrailingRegular, buttonTopRegular, buttonWidthRegular]
        regularConstraints.append(contentsOf: buttonCenter)
        
        let cardTrailingCompact = cardView.trailing(to: controls.leadingAnchor, withOffset: Layout.Spacing.standard, activate: false)
        let cardCenterCompact = cardView.center(on: view, axis: .y, activate: false)
        
        let buttonCenterCompact = controls.center(on: view, axis: .y, activate: false)
        let buttonLeadingCompact = controls.leading(to: cardView.trailingAnchor, withOffset: Layout.Spacing.standard, activate: false)
        let buttonTrailingCompact = controls.trailing(to: view.trailingAnchor, withOffset: Layout.Spacing.standard, activate: false)
        let buttonWidthCompact = controls.width(to: 200, activate: false)
        
        compactConstraints = [cardTrailingCompact, buttonLeadingCompact, buttonTrailingCompact, buttonWidthCompact]
        compactConstraints.append(contentsOf: buttonCenterCompact)
        compactConstraints.append(contentsOf: cardCenterCompact)
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

// MARK: - delegates

extension ReviewViewController: ReviewControlsDelegate {
    func flip() {
        cardController.flipCurrentCard()
    }
    
    func next() {
        cardController.nextCard()
    }
    
    func previous() {
        cardController.previousCard()
    }
    
    func ratedCard(withRating rating: Rating) {
        reviewSession?.cardRated(withRating: rating)
        cardController.nextCard()
        ratingController.setSelectedButton(rating: nil)
    }
}

extension ReviewViewController: ReviewDeckDelegate {
    func displayedCardUpdated(showingFront: Bool) {
        if showingFront {
            ratingController.disable()
        } else {
            ratingController.enable()
        }
        if let card = reviewSession?.currentCard {
            ratingController.setSelectedButton(rating: card.rating)
        }
    }
    
    func reviewSessionShouldEnd(_ log: ReviewSessionLog) {
        let notification = NotificationBanner(title: "session complete!")
        notification.show()
        ShortReviewScheduler().schedule(session: log)
    }
}
