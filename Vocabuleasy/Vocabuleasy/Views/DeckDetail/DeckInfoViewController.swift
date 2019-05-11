//
//  DeckInfoViewController.swift
//  Vocabuleasy
//
//  Created by Eric Groom on 5/6/19.
//  Copyright © 2019 Eric Groom. All rights reserved.
//

import UIKit
import CoreData

class DeckInfoViewController: UIViewController {
    
    var deck: Deck?
    
    enum State {
        case empty
        case loaded(total: Int, upcoming: Int)
        case error(Error)
    }
    
    private var state: State = .empty {
        didSet {
            updateLabelText()
        }
    }

    private lazy var totalLabel = makeLabel()
    private lazy var upcomingLabel = makeLabel()
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = Layout.Spacing.small
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(stackView)
        stackView.fill(parent: view)
        stackView.addArrangedSubview(totalLabel)
        stackView.addArrangedSubview(upcomingLabel)

        setupListener()
        update()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        update()
    }
    
    private func makeLabel() -> UILabel {
        let label = UILabel()
        label.font = Theme.Fonts.bold
        label.textColor = Theme.white
        label.textAlignment = .center
        return label
    }
    
    @objc private func update() {
        guard let deck = deck else { return }
        let context = ContainerService.shared.persistentContainer.viewContext
        let allRequest = deck.allCards()
        let upcomingRequest = deck.whereNeedsReview()
        do {
            let allCount = try context.count(for: allRequest)
            let upcomingCount = try context.count(for: upcomingRequest)
            state = .loaded(total: allCount, upcoming: upcomingCount)
        } catch {
            state = .error(error)
        }
    }
    
    private func updateLabelText() {
        switch state {
        case .empty:
            upcomingLabel.text = nil
            totalLabel.text = nil
        case .loaded(let total, let upcoming):
            upcomingLabel.text = "\(upcoming) reviews ready"
            totalLabel.text = "\(total) total cards"
        case .error(_):
            upcomingLabel.text = nil
            totalLabel.text = "Error loading deck statistics"
        }
    }
    
    private func setupListener() {
        let context = ContainerService.shared.persistentContainer.viewContext
        NotificationCenter.default.addObserver(self, selector: #selector(update), name: .NSManagedObjectContextObjectsDidChange, object: context)
    }
}
