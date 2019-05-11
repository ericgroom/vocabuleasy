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
            guard let model = model else { return }
            let frontLabel = UILabel()
            frontLabel.text = model.data?.targetWord
            front.addArrangedSubview(frontLabel)
            let backLabel = UILabel()
            backLabel.text = model.data?.translation
            back.addArrangedSubview(backLabel)
        }
    }
    
    private let front = CardBackgroundView()
    private let back = CardBackgroundView()
    
    var flipDuration: TimeInterval = 0.4
    
    private(set) var showingFront = true
    private(set) var animating = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        back.isHidden = true

        view.addSubview(front)
        view.addSubview(back)
        
        front.fill(parent: view)
        back.fill(parent: view)
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

}
