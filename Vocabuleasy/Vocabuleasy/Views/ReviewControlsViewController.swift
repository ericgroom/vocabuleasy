//
//  ReviewControlViewController.swift
//  Vocabuleasy
//
//  Created by Eric Groom on 4/22/19.
//  Copyright © 2019 Eric Groom. All rights reserved.
//

import UIKit
import Hero

class ReviewControlsViewController: UIViewController {

    
    weak var delegate: ReviewControlsDelegate?
    
    enum Controls {
        case sequence, rating
    }
    
    var displayedControl: Controls = .rating {
        didSet {
            let from: UIViewController, to: UIViewController
            switch displayedControl {
            case .sequence:
                from = ratingControls
                to = sequenceControls
            case .rating:
                from = sequenceControls
                to = ratingControls
            }
            embed(to)
            animateTransition(from: from.view, to: to.view)
        }
    }
    
    func enable() {
        guard let vc = currentVC as? Disableable else { return }
        vc.enable()
    }
    
    func disable() {
        guard let vc = currentVC as? Disableable else { return }
        vc.disable()
    }

    private let sequenceControls = ReviewSequenceViewController()
    private let ratingControls = ReviewRatingViewController()
    
    private var currentVC: UIViewController {
        switch displayedControl {
        case .rating:
            return ratingControls
        case .sequence:
            return sequenceControls
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sequenceControls.delegate = self
        ratingControls.delegate = self
        
        embed(currentVC)
        currentVC.view.fill(parent: view)
    }
    
    private func animateTransition(from: UIView, to: UIView) {
        to.fill(parent: view)
        to.transform = CGAffineTransform(translationX: 0, y: -50)
        to.alpha = 0
        UIView.animate(withDuration: 0.3, delay: 0, options: [], animations: {
            to.transform = CGAffineTransform(translationX: 0, y: 0)
            to.alpha = 1.0
            
        })
        
        UIView.animate(withDuration: 0.2, delay: 0, options: [], animations: {
            from.transform = CGAffineTransform(translationX: 0, y: 50)
            from.alpha = 0
        }) { (_) in
            from.removeFromSuperview()
        }
    }
}

protocol ReviewControlsDelegate: class {
    func flip()
    func next()
    func previous()
    func ratedCard(withRating rating: Rating)
}

protocol Disableable {
    func enable()
    func disable()
}

extension ReviewControlsViewController: ReviewSequenceDelegate {
    func flip() {
        delegate?.flip()
    }
    
    func next() {
        delegate?.next()
    }
    
    func previous() {
        delegate?.previous()
    }
}

extension ReviewControlsViewController: ReviewRatingDelegate {
    func ratedCard(withRating rating: Rating) {
        delegate?.ratedCard(withRating: rating)
    }
}
