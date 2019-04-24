//
//  RatingViewController.swift
//  Vocabuleasy
//
//  Created by Eric Groom on 4/22/19.
//  Copyright © 2019 Eric Groom. All rights reserved.
//

import UIKit

class ReviewRatingViewController: UIViewController {
    
    weak var delegate: ReviewRatingDelegate?
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = Layout.Spacing.standard
        return stackView
    }()
    
    private lazy var wrongButton: UIButton = makeImageButton(image: #imageLiteral(resourceName: "cross"), #selector(wrongPressed))
    private lazy var mehButton = makeImageButton(image: #imageLiteral(resourceName: "Tilde"), #selector(mehPressed))
    private lazy var correctButton = makeImageButton(image: #imageLiteral(resourceName: "Check"), #selector(correctPressed))

    override func viewDidLoad() {
        super.viewDidLoad()

        for button in [wrongButton, mehButton, correctButton] {
            button.width(to: button.heightAnchor, withMultiplier: 1.0)
            stackView.addArrangedSubview(button)
        }
        view.addSubview(stackView)
        stackView.fill(parent: view)
    }
    
    private func makeButton(_ title: String, _ selector: Selector) -> UIButton {
        let button = UIButton()
        button.setTitle(title, for: .normal)
        button.backgroundColor = Theme.purple
        button.tintColor = .white
        button.setTitleColor(.darkGray, for: .disabled)
        button.layer.cornerRadius = 8.0
        button.contentEdgeInsets = UIEdgeInsets(top: 20, left: 0, bottom: 20, right: 0)
        button.addTarget(self, action: selector, for: .touchUpInside)
        return button
    }
    
    private func makeSymbolButton(symbol: SymbolView.Type, _ selector: Selector) -> UIButton {
        let button = UIButton()
        
        button.layer.cornerRadius = 8.0
        button.contentEdgeInsets = UIEdgeInsets(top: 20, left: 0, bottom: 20, right: 0)
        button.addTarget(self, action: selector, for: .touchUpInside)
        button.setTitle(nil, for: .normal)
        button.backgroundColor = Theme.purple
        
        let symbolView = symbol.init()
        button.addSubview(symbolView)
        symbolView.color = .white
        symbolView.backgroundColor = .clear
        symbolView.fill(parent: button, withOffset: Layout.Spacing.standard)
        symbolView.width(to: symbolView.heightAnchor, withMultiplier: 1.0).priority = .defaultHigh
        symbolView.lineWidth = 15
        return button
    }
    
    private func makeImageButton(image: UIImage, _ selector: Selector) -> UIButton {
        let button = RatingButton()
        
        button.layer.cornerRadius = 8.0
        button.contentEdgeInsets = UIEdgeInsets(top: 20, left: 0, bottom: 20, right: 0)
        button.addTarget(self, action: #selector(correctPressed), for: .touchUpInside)
        button.setTitle(nil, for: .normal)
        button.backgroundColor = Theme.purple
        button.disabledBackgroundColor = .darkGray
        
        let normalImage = image.withRenderingMode(.alwaysTemplate)
        
        button.setImage(normalImage, for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.alpha = 1.0
        button.imageView?.alpha = 1.0
        button.tintColor = .white
        return button
    }
    
    @objc private func wrongPressed() {
        delegate?.ratedCard(withRating: .wrong)
    }
    
    @objc private func mehPressed() {
        delegate?.ratedCard(withRating: .meh)
    }
    
    @objc private func correctPressed() {
        delegate?.ratedCard(withRating: .correct)
    }

}

enum Rating {
    case correct, meh, wrong
}

protocol ReviewRatingDelegate: class {
    func ratedCard(withRating rating: Rating)
}

extension ReviewRatingViewController: Disableable {
    func enable() {
        wrongButton.isEnabled = true
        mehButton.isEnabled = true
        correctButton.isEnabled = true
    }
    
    func disable() {
        wrongButton.isEnabled = false
        mehButton.isEnabled = false
        correctButton.isEnabled = false
    }
}
