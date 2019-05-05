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
    
    func setSelectedButton(rating: Rating?) {
        wrongButton.isSelected = false
        mehButton.isSelected = false
        correctButton.isSelected = false
        guard let rating = rating else { return }
        switch rating {
        case .correct:
            correctButton.isSelected = true
        case .meh:
            mehButton.isSelected = true
        case .wrong:
            wrongButton.isSelected = true
        }
    }
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = Layout.Spacing.standard
        return stackView
    }()
    
    private lazy var wrongButton: UIButton = makeImageButton(image: #imageLiteral(resourceName: "cross"), backgroundColor: Theme.Ratings.bad, #selector(wrongPressed))
    private lazy var mehButton = makeImageButton(image: #imageLiteral(resourceName: "Tilde"), backgroundColor: Theme.Ratings.warning, #selector(mehPressed))
    private lazy var correctButton = makeImageButton(image: #imageLiteral(resourceName: "Check"), backgroundColor: Theme.Ratings.good, #selector(correctPressed))

    override func viewDidLoad() {
        super.viewDidLoad()

        for button in [wrongButton, mehButton, correctButton] {
            button.width(to: button.heightAnchor, withMultiplier: 1.0)
            stackView.addArrangedSubview(button)
        }
        view.addSubview(stackView)
        stackView.fill(parent: view)
    }
    
    private func makeImageButton(image: UIImage, backgroundColor: UIColor, _ selector: Selector) -> UIButton {
        let button = ThreeDPressButton()
        let shadowDistance: CGFloat = 4.0
        let darkeningFactor: CGFloat = 0.9
        
        button.layer.cornerRadius = 8.0
        button.contentEdgeInsets = UIEdgeInsets(top: 20, left: 0, bottom: 20, right: 0)
        button.addTarget(self, action: selector, for: .touchUpInside)
        button.setTitle(nil, for: .normal)
        button.enabledBackgroundColor = backgroundColor
        if let shadowColor = backgroundColor.darkened(by: darkeningFactor) {
            button.clipsToBounds = false
            button.enabledShadowColor = shadowColor
            button.layer.shadowOpacity = 1.0
            button.layer.shadowRadius = 0.0
            button.layer.shadowOffset = CGSize(width: shadowDistance, height: shadowDistance)
            button.adjustsImageWhenHighlighted = false
            button.pressTransform = CGAffineTransform(translationX: shadowDistance, y: shadowDistance)
        }
       
        button.disabledBackgroundColor = .darkGray
        button.disabledShadowColor = UIColor.darkGray.darkened(by: darkeningFactor)
        
        let templateImage = image.withRenderingMode(.alwaysTemplate)
        
        button.setImage(templateImage, for: .normal)
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

protocol ReviewRatingDelegate: class {
    func ratedCard(withRating rating: Rating)
}

protocol Disableable {
    func enable()
    func disable()
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
