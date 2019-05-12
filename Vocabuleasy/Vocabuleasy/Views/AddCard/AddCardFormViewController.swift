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
    
    var image: UIImage? {
        get {
            return imageField.image
        }
        set {
            imageField.image = newValue
        }
    }
    
    private let card = CardBackgroundView()
    private let frontLabel = LabeledTextField()
    private let backLabel = LabeledTextField()
    private let imageField = ImageFieldViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        frontLabel.name = "Target Word"
        backLabel.name = "Translation"
        
        addChild(imageField)
        
        card.addArrangedSubview(frontLabel)
        card.addArrangedSubview(backLabel)
        card.addArrangedSubview(imageField.view)
        view.addSubview(card)
        card.fill(parent: view, withOffset: Layout.Spacing.standard)
        let cardInset = -Layout.Spacing.standard*2
        frontLabel.width(to: card, withOffset: cardInset)
        frontLabel.center(on: card, axis: .x)
        backLabel.width(to: card, withOffset: cardInset)
        backLabel.center(on: card, axis: .x)
        
        
        imageField.view.height(.lessOrEqual, to: 250)
        imageField.view.width(to: card, withOffset: cardInset)
    }
    
    func clear() {
        frontLabel.text = ""
        backLabel.text = ""
        imageField.image = nil
    }
}
