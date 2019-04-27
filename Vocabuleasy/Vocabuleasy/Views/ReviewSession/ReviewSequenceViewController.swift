//
//  ReviewSequenceViewController.swift
//  Vocabuleasy
//
//  Created by Eric Groom on 4/22/19.
//  Copyright © 2019 Eric Groom. All rights reserved.
//

import UIKit

class ReviewSequenceViewController: UIViewController {
    
    weak var delegate: ReviewSequenceDelegate?

    private lazy var flipButton: UIButton = makeButton("flip", #selector(flipButtonPressed))
    private lazy var nextButton: UIButton = makeButton("next", #selector(nextButtonPressed))
    private lazy var prevButton: UIButton = makeButton("previous", #selector(prevButtonPressed))
    
    private var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = Layout.Spacing.small
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        stackView.addArrangedSubview(flipButton)
        stackView.addArrangedSubview(nextButton)
        stackView.addArrangedSubview(prevButton)
        view.addSubview(stackView)
        stackView.fill(parent: view)
    }
    
    @objc private func flipButtonPressed() {
        delegate?.flip()
    }
    
    @objc private func nextButtonPressed() {
        delegate?.next()
    }
    
    @objc private func prevButtonPressed() {
        delegate?.previous()
    }
    
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

}

protocol ReviewSequenceDelegate: class {
    func flip()
    func next()
    func previous()
}
