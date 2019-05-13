//
//  ReviewView.swift
//  Vocabuleasy
//
//  Created by Eric Groom on 5/13/19.
//  Copyright © 2019 Eric Groom. All rights reserved.
//

import UIKit

class ReviewView: UIView {

    var cardView: UIView!
    var controls: UIView!
    
    private var regularConstraints: [NSLayoutConstraint] = []
    private var compactConstraints: [NSLayoutConstraint] = []
    
    func setupConstraints() {
        // universal
        cardView.leading(to: self.leadingAnchor, withOffset: Layout.Spacing.standard)
        cardView.height(to: cardView.widthAnchor, withMultiplier: 1.75/Layout.goldenRatio, priority: .defaultLow)
        
        // regular constraints
        let cardTopRegular = cardView.top(to: self.topAnchor, withOffset: Layout.Spacing.standard, activate: false)
        let cardTrailingRegular = cardView.trailing(to: self.trailingAnchor, withOffset: Layout.Spacing.standard, activate: false)
        
        let buttonWidthRegular = controls.width(to: cardView, activate: false)
        let buttonTopRegular = controls.top(to: cardView.bottomAnchor, withOffset: Layout.Spacing.standard, activate: false)
        let buttonCenter = controls.center(on: self, axis: .x, activate: false)
        regularConstraints = [cardTopRegular, cardTrailingRegular, buttonTopRegular, buttonWidthRegular]
        regularConstraints.append(contentsOf: buttonCenter)
        
        let cardTopCompact = cardView.top(to: self.topAnchor, withOffset: Layout.Spacing.standard, activate: false)
        let cardBottomCompact = cardView.bottom(to: self.bottomAnchor, withOffset: Layout.Spacing.standard, activate: false)
        let cardTrailingCompact = cardView.trailing(to: controls.leadingAnchor, withOffset: Layout.Spacing.standard, activate: false)
//        let cardCenterCompact = cardView.center(on: self, axis: .y, activate: false)
        
        let buttonCenterCompact = controls.center(on: self, axis: .y, activate: false)
        let buttonLeadingCompact = controls.leading(to: cardView.trailingAnchor, withOffset: Layout.Spacing.standard, activate: false)
        let buttonTrailingCompact = controls.trailing(to: self.trailingAnchor, withOffset: Layout.Spacing.standard, activate: false)
        let buttonWidthCompact = controls.width(to: 200, activate: false)
        
        compactConstraints = [cardTrailingCompact, buttonLeadingCompact, buttonTrailingCompact, buttonWidthCompact, cardTopCompact, cardBottomCompact]
        compactConstraints.append(contentsOf: buttonCenterCompact)
//        compactConstraints.append(contentsOf: cardCenterCompact)
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
        self.layoutIfNeeded()
    }

}
