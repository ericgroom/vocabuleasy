//
//  ReviewViewController.swift
//  Vocabuleasy
//
//  Created by Eric Groom on 4/18/19.
//  Copyright © 2019 Eric Groom. All rights reserved.
//

import UIKit
import NotificationBannerSwift

class ReviewViewController: UIViewController {
    
    var reviewSession: ReviewSession? {
        didSet {
            cardController.reviewSession = reviewSession
        }
    }
    
    private var cardController = ReviewDeckController()
    private var ratingController = ReviewRatingViewController()
    
    private var cardView: UIView { return cardController.view }
    private var controls: UIView { return ratingController.view }
    
    private var cardGestureRecognizer: CardGestureRecognizer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let reviewView = ReviewView()
        self.view = reviewView
        view.backgroundColor = Theme.green
        navigationItem.title = "Review"
        
        hero.isEnabled = true
        
        cardController.delegate = self
        ratingController.delegate = self
        ratingController.disable()
        
        cardGestureRecognizer = CardGestureRecognizer(cardView: cardView)
        cardGestureRecognizer?.delegate = self
        
        embed(cardController)
        embed(ratingController)
        
        cardView.hero.id = "cardBackground"
        
        reviewView.cardView = cardView
        reviewView.controls = controls
        reviewView.setupConstraints()
    }
}

// MARK: - delegates

extension ReviewViewController: ReviewControlsDelegate {
    func flip() {
        cardController.flipCurrentCard()
    }
    
    func next() {
        cardController.nextCard()
    }
    
    func previous() {
        cardController.previousCard()
    }
    
    func ratedCard(withRating rating: Rating) {
        reviewSession?.cardRated(withRating: rating)
        cardController.nextCard()
        ratingController.setSelectedButton(rating: nil)
    }
}

extension ReviewViewController: ReviewDeckDelegate {
    func displayedCardUpdated(showingFront: Bool) {
        if showingFront {
            ratingController.disable()
        } else {
            ratingController.enable()
        }
        if let card = reviewSession?.currentCard {
            ratingController.setSelectedButton(rating: card.rating)
        }
    }
    
    func reviewSessionShouldEnd() {
        guard let session = reviewSession else { return }
        let notification = NotificationBanner(title: "session complete!")
        notification.show()
        let log = session.complete()
        FibonacciReviewScheduler(baseInterval: 60).schedule(session: log)
        if let card = log.cardsReviewed.first, let context = card.card.managedObjectContext {
            do {
                try context.save()
                let vc = PostReviewViewController()
                vc.state = .loaded(log: log)
                hero.replaceViewController(with: vc)
            } catch {
                print(error)
                NotificationService.showErrorBanner(withText: "Error saving review session")
            }
        }
    }
}
