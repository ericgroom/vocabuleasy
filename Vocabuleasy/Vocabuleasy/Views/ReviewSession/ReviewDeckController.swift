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
    
    var reviewSession: ReviewSession? {
        didSet {
            setupSession()
        }
    }
    
    weak var delegate: ReviewDeckDelegate?
    private var currentCard: CardViewController?
    
    var currentView: UIView? {
        return currentCard?.view
    }
    
    var showingFront: Bool? {
        guard let current = currentCard else { return nil }
        return current.showingFront
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hero.isEnabled = true
    }
    
    private func setupSession() {
        guard let reviewSession = reviewSession else { return }
        if reviewSession.count > 0 {
            let card = reviewSession.get(atIndex: reviewSession.currentIndex)
            currentCard = CardViewController()
            currentCard?.model = card
            if let cardController = currentCard {
                embed(cardController)
                cardController.view.fill(parent: view)
            }
            delegate?.displayedCardUpdated(showingFront: true)
        }
    }
    
    func nextCard() {
        guard let session = reviewSession else { return }
        let next = session.advance()
        if let card = next {
            transition(to: card, direction: .forward)
        } else {
            shakeCard()
        }
    }
    
    func previousCard() {
        guard let session = reviewSession else { return }
        let prev = session.previousCard()
        if let card = prev {
            transition(to: card, direction: .backward)
        } else {
            shakeCard()
        }
    }
    
    func flipCurrentCard() {
        guard let current = currentCard else { return }
        current.flipCard()
        delegate?.displayedCardUpdated(showingFront: current.showingFront)
    }
    
    // MARK: - Animations
    
    func shakeCard() {
        guard let current = currentView else { return }
        ShakeAnimationController.shake(current, maxAngleInRadians: 5*CGFloat.pi/180, duration: 0.5)
    }
    
    enum Direction {
        case forward, backward
        
        func toHero() -> HeroDefaultAnimationType.Direction {
            switch self {
            case .forward:
                return .left
            case .backward:
                return .right
            }
        }
    }

    private func transition(to card: Card, direction: Direction) {
        guard let current = currentCard else { return }
        let next = CardViewController()
        next.model = card
        embed(next)
        next.view.fill(parent: view)
    
        // TODO: - use pageIn for incorrect answer and zoomSlide for correct answer
        next.hero.modalAnimationType = .zoomSlide(direction: direction.toHero())
        Hero.shared.transition(from: current, to: next, in: view) { [weak self] completed in
            self?.delegate?.displayedCardUpdated(showingFront: next.showingFront)
            self?.currentCard = next
        }
    }

}

protocol ReviewDeckDelegate: class {
    func displayedCardUpdated(showingFront: Bool)
}
