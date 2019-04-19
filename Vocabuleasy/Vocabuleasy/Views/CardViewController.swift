//
//  CardViewController.swift
//  Vocabuleasy
//
//  Created by Eric Groom on 4/18/19.
//  Copyright © 2019 Eric Groom. All rights reserved.
//

import UIKit

class CardViewController: UIViewController {
    
    let front = CardBackgroundView()
    let back = CardBackgroundView()
    
    private var showingFront = true
    private var animating = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        back.isHidden = true

        view.addSubview(front)
        view.addSubview(back)
        
        front.fill(parent: view)
        back.fill(parent: view)
        
        let frontLabel = UILabel()
        frontLabel.text = "front"
        front.addArrangedSubview(frontLabel)
        
        makeLabels(count: 50).forEach {
            back.addArrangedSubview($0)
        }
    }
    
    private func makeLabels(count: Int) -> [UILabel] {
        return (0...count).map { i in
            let label = UILabel()
            label.text = "Label \(i)"
            return label
        }
    }
    
    func flipCard() {
        if showingFront {
            animating = true
            UIView.transition(from: front, to: back, duration: 1.0, options: [.transitionFlipFromLeft, .showHideTransitionViews, .preferredFramesPerSecond60, .curveEaseInOut, .beginFromCurrentState], completion: { [weak self] completed in
                self?.animating = false
            })
        } else {
            animating = true
            UIView.transition(from: back, to: front, duration: 1.0, options: [.transitionFlipFromLeft, .showHideTransitionViews, .preferredFramesPerSecond60, .curveEaseInOut, .beginFromCurrentState], completion: { [weak self] completed in
                self?.animating = false
            })
        }
        showingFront = !showingFront
    }

}
