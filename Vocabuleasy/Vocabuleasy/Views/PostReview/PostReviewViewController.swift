//
//  PostReviewViewController.swift
//  Vocabuleasy
//
//  Created by Eric Groom on 5/7/19.
//  Copyright © 2019 Eric Groom. All rights reserved.
//

import UIKit

class PostReviewViewController: UIViewController {
    
    enum State {
        case empty
        case loaded(log: ReviewSessionLog)
        case error(Error)
    }
    
    var state: State = .empty {
        didSet {
            updateLabel()
        }
    }
    
    private let infoLabel: UILabel = {
        let label = UILabel()
        label.font = Theme.Fonts.bold
        label.textColor = Theme.white
        label.numberOfLines = 0
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Theme.green
        
        view.addSubview(infoLabel)
        infoLabel.center(on: view)
    }
    
    private func updateLabel() {
        switch state {
        case .empty:
            infoLabel.text = "empty"
            infoLabel.textColor = .lightGray
        case .loaded(let log):
            let ratingCounts = log.getRatingCount()
            infoLabel.text = """
            Done reviewing \(log.cardsReviewed.count) cards
            Wrong: \(ratingCounts[.wrong]!)
            Meh: \(ratingCounts[.meh]!)
            Correct: \(ratingCounts[.correct]!)
            """
            infoLabel.textColor = Theme.white
        case .error(_):
            infoLabel.text = "Error occurred loading the session info"
            infoLabel.textColor = .red
        }
    }
}
