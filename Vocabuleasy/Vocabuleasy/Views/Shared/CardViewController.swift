//
//  CardViewController.swift
//  Vocabuleasy
//
//  Created by Eric Groom on 4/18/19.
//  Copyright © 2019 Eric Groom. All rights reserved.
//

import UIKit

class CardViewController: UIViewController {
    
    var model: Card? {
        didSet {
            updateView()
        }
    }
    
    private let frontLabel = UILabel()
    private let backLabel = UILabel()
    private let exampleLabel = UILabel()
    private let imageView = UIImageView()
    private var imageHeightConstraint: NSLayoutConstraint?
    
    private let front = CardBackgroundView()
    private let back = CardBackgroundView()
    
    var flipDuration: TimeInterval = 0.4
    
    private(set) var showingFront = true
    private(set) var animating = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        front.addArrangedSubview(frontLabel)
        back.addArrangedSubview(backLabel)
        back.addArrangedSubview(exampleLabel)
        back.addArrangedSubview(imageView)
        back.isHidden = true

        view.addSubview(front)
        view.addSubview(back)
        
        front.fill(parent: view)
        back.fill(parent: view)
        
        imageView.contentMode = .scaleAspectFit
        imageView.width(to: view, withOffset: -2*Layout.Spacing.standard)
        
        
        
        frontLabel.numberOfLines = 0
        backLabel.numberOfLines = 0
        exampleLabel.numberOfLines = 0
    }
    
    func flipCard() {
        if showingFront {
            animating = true
            UIView.transition(from: front, to: back, duration: flipDuration, options: [.transitionFlipFromLeft, .showHideTransitionViews, .preferredFramesPerSecond60, .curveEaseInOut, .beginFromCurrentState], completion: { [weak self] completed in
                self?.animating = false
            })
        } else {
            animating = true
            UIView.transition(from: back, to: front, duration: flipDuration, options: [.transitionFlipFromLeft, .showHideTransitionViews, .preferredFramesPerSecond60, .curveEaseInOut, .beginFromCurrentState], completion: { [weak self] completed in
                self?.animating = false
            })
        }
        showingFront = !showingFront
    }
    
    func updateView() {
        guard let model = model else { return }
        if model.reversed {
            frontLabel.text = model.data?.translation
            backLabel.text = model.data?.targetWord
        } else {
            frontLabel.text = model.data?.targetWord
            backLabel.text = model.data?.translation
        }
        frontLabel.font = Theme.Fonts.largeWord
        backLabel.font = Theme.Fonts.semibold
        exampleLabel.text = model.data?.example
        
        if let imageData = model.data?.photo, let image = UIImage(data: imageData) {
            imageView.image = image
            let aspectRatio = 1/image.size.aspectRatio
            if let constraint = imageHeightConstraint {
                constraint.isActive = false
            }
            imageHeightConstraint = imageView.height(to: imageView.widthAnchor, withMultiplier: aspectRatio)
            
        }
    }

}
