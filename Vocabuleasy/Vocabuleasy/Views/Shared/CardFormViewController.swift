//
//  AddCardFormViewController.swift
//  Vocabuleasy
//
//  Created by Eric Groom on 5/4/19.
//  Copyright © 2019 Eric Groom. All rights reserved.
//

import UIKit

protocol CardFormDelegate: class {
    func generateExampleTapped(for targetWord: String)
}

class CardFormViewController: UIViewController {
    
    weak var delegate: CardFormDelegate?
    
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
    
    var exampleText: String? {
        get {
            return exampleLabel.text
        }
        set {
            exampleLabel.text = newValue
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
    private let exampleLabel = LabeledTextField()
    private let imageField = ImageFieldViewController()
    private let exampleStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = UIStackView.Alignment.bottom
        stackView.spacing = Layout.Spacing.small
        return stackView
    }()
    
    private let autoFillExampleButton: UIButton = {
        let button = UIButton()
        button.setTitle("Auto-fill", for: .normal)
        button.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        button.setTitleColor(Theme.white, for: .normal)
        button.backgroundColor = Theme.purple
        button.addTarget(self, action: #selector(generateExample), for: .touchUpInside)
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViews()
        
        exampleStackView.addArrangedSubview(exampleLabel)
        exampleStackView.addArrangedSubview(autoFillExampleButton)
        
        card.stackView.stackView.spacing = Layout.Spacing.standard
        card.addArrangedSubview(frontLabel)
        card.addArrangedSubview(backLabel)
        card.addArrangedSubview(exampleStackView)
        addChild(imageField)
        card.addArrangedSubview(imageField.view)
        
        view.addSubview(card)
        setupContstraints()
    }
    
    func clear() {
        frontLabel.text = nil
        backLabel.text = nil
        exampleLabel.text = nil
        imageField.image = nil
    }
    
    @objc private func generateExample() {
        guard let word = frontText, word.count > 0 else { return }
        delegate?.generateExampleTapped(for: word)
        
 
    }
    
    private func configureViews() {
        frontLabel.name = "Target Word"
        backLabel.name = "Translation or Definition"
        exampleLabel.name = "Example"
        autoFillExampleButton.layer.cornerRadius = exampleLabel.textField.layer.cornerRadius
    }
    
    private func setupContstraints() {
        card.fill(parent: view, withOffset: Layout.Spacing.standard)
        let cardInset = -Layout.Spacing.standard*2
        frontLabel.width(to: card, withOffset: cardInset)
        backLabel.width(to: card, withOffset: cardInset)
        exampleStackView.width(to: card, withOffset: cardInset)
        autoFillExampleButton.height(to: exampleLabel.textField)
        imageField.view.height(.lessOrEqual, to: 250)
        imageField.view.width(to: card, withOffset: cardInset)
    }
}
