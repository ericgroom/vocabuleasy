//
//  AddCardFormViewController.swift
//  Vocabuleasy
//
//  Created by Eric Groom on 5/4/19.
//  Copyright © 2019 Eric Groom. All rights reserved.
//

import UIKit

class AddCardFormViewController: UIViewController {
    
    var frontText: String? {
        get {
            return frontLabel.text
        } set {
            frontLabel.text = newValue
        }
    }
    
    var backText: String? {
        get {
            return backLabel.text
        } set {
            backLabel.text = newValue
        }
    }
    
    private let card = CardBackgroundView()
    private let frontLabel = LabeledTextField()
    private let backLabel = LabeledTextField()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        frontLabel.name = "front"
        backLabel.name = "back"
        
        card.addArrangedSubview(frontLabel)
        card.addArrangedSubview(backLabel)
        view.addSubview(card)
        card.fill(parent: view, withOffset: Layout.Spacing.standard)
        frontLabel.width(to: card, withOffset: -Layout.Spacing.standard*2)
        frontLabel.center(on: card, axis: .x)
        backLabel.width(to: card, withOffset: -Layout.Spacing.standard*2)
        backLabel.center(on: card, axis: .x)
    }
    
    func clear() {
        frontLabel.text = ""
        backLabel.text = ""
    }
}
