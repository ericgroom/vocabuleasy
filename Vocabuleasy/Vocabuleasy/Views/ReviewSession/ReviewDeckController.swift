//
//  ReivewDeckController.swift
//  Vocabuleasy
//
//  Created by Eric Groom on 4/20/19.
//  Copyright © 2019 Eric Groom. All rights reserved.
//

import UIKit
import Hero

class ReviewDeckController: UIViewController {
    
    weak var delegate: ReviewDeckDelegate?
    
    private var cards: [CardViewController] = []
    
    var currentIndex: Int?
    
    var currentView: UIView? {
        guard let i = currentIndex else { return nil }
        return cards[i].view
    }
    
    var showingFront: Bool? {
        guard let i = currentIndex else { return nil }
        return cards[i].showingFront
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hero.isEnabled = true
        
        generateTestCards()
        
        if cards.count > 0 {
            currentIndex = 0
            embed(cards[currentIndex!])
            cards[currentIndex!].view.fill(parent: view)
            delegate?.displayedCardUpdated(showingFront: true)
        }
    }
    
    func nextCard() {
        guard let index = currentIndex else { return }
        let next = cards.index(after: index)
        if next < cards.count {
            transition(from: index, to: next)
        } else {
            shakeCard()
        }
    }
    
    func previousCard() {
        guard let index = currentIndex else { return }
        let prev = cards.index(before: index)
        if prev >= 0 {
            transition(from: index, to: prev)
        } else {
            shakeCard()
        }
    }
    
    func flipCurrentCard() {
        guard let index = currentIndex else { return }
        let current = cards[index]
        current.flipCard()
        delegate?.displayedCardUpdated(showingFront: current.showingFront)
    }
    
    // MARK: - Animations
    
    func shakeCard() {
        guard let current = currentView else { return }
        ShakeAnimationController.shake(current, maxAngleInRadians: 5*CGFloat.pi/180, duration: 0.5)
    }

    private func transition(from currentIndex: Int, to nextIndex: Int) {
        let current = cards[currentIndex], next = cards[nextIndex]
        
        let direction: HeroDefaultAnimationType.Direction = currentIndex < nextIndex ? .left : .right
        
        embed(next)
        next.view.fill(parent: view)
    
        // TODO: - use pageIn for incorrect answer and zoomSlide for correct answer
        next.hero.modalAnimationType = .zoomSlide(direction: direction)
        Hero.shared.transition(from: current, to: next, in: view) { [weak self] completed in
            self?.currentIndex = nextIndex
            self?.delegate?.displayedCardUpdated(showingFront: next.showingFront)
        }
    }
    
    // MARK: - Mock data
    func generateTestCards() {
        for i in 0...4 {
            let cardController = CardViewController()
            let frontLabel = UILabel()
            frontLabel.text = "front \(i)"
            frontLabel.textAlignment = .center
            let backLabel = UILabel()
            backLabel.text = "back \(i)"
            backLabel.textAlignment = .center
            let frontFields = CardFieldBuilder().addField(view: frontLabel).build()
            let backFields = CardFieldBuilder().addField(view: backLabel).build()
            cardController.cardFields = CardFields(frontFields: frontFields, backFields: backFields)
            cards.append(cardController)
        }
    }

}

protocol ReviewDeckDelegate: class {
    func displayedCardUpdated(showingFront: Bool)
}
