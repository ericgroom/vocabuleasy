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
    
    var deck: Deck?
    
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
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(showMenu))
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
    
    @objc private func showMenu() {
        guard let card = reviewSession?.currentCard?.card else { return }
        let editVC = EditCardViewController()
        editVC.mode = .edit(card)
        editVC.delegate = self
        editVC.deck = deck
        let navVC = UINavigationController(rootViewController: editVC)
        NavigationStyler.applyTheme(to: navVC)
        self.present(navVC, animated: true, completion: nil)
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

extension ReviewViewController: EditCardDelegate {
    func didFinishEditing() {
        cardController.currentCard?.updateView()
    }
}
