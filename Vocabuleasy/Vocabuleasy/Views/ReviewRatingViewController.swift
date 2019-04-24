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
        return stackView
    }()
    
    private lazy var wrongButton = makeButton("Wrong", #selector(wrongPressed))
    private lazy var mehButton = makeButton("Meh", #selector(mehPressed))
    private lazy var correctButton = makeButton("Right", #selector(correctPressed))

    override func viewDidLoad() {
        super.viewDidLoad()

        stackView.addArrangedSubview(wrongButton)
        stackView.addArrangedSubview(mehButton)
        stackView.addArrangedSubview(correctButton)
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
