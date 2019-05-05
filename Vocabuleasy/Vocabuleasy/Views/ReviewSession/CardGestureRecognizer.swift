//
//  CardGestureRecognizer.swift
//  Vocabuleasy
//
//  Created by Eric Groom on 4/24/19.
//  Copyright © 2019 Eric Groom. All rights reserved.
//

import UIKit

class CardGestureRecognizer {
    weak var cardView: UIView?
    weak var delegate: ReviewSequenceDelegate?
    
    init(cardView: UIView) {
        self.cardView = cardView
        
        setupRecognizers()
    }
    
    private func setupRecognizers() {
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(cardTapped))
        
        let swipeLeftRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(swipeLeft))
        swipeLeftRecognizer.direction = .left
        
        let swipeRightRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(swipeRight))
        swipeRightRecognizer.direction = .right
        
        cardView?.addGestureRecognizer(tapRecognizer)
        cardView?.addGestureRecognizer(swipeLeftRecognizer)
        cardView?.addGestureRecognizer(swipeRightRecognizer)
    }
    
    @objc private func cardTapped() {
        delegate?.flip()
    }
    
    @objc private func swipeLeft() {
        delegate?.next()
    }
    
    @objc private func swipeRight() {
        delegate?.previous()
    }
}

protocol ReviewSequenceDelegate: class {
    func flip()
    func next()
    func previous()
}
