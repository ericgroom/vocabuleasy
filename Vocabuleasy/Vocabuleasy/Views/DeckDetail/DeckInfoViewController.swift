//
//  DeckInfoViewController.swift
//  Vocabuleasy
//
//  Created by Eric Groom on 5/6/19.
//  Copyright © 2019 Eric Groom. All rights reserved.
//

import UIKit
import CoreData
import SwiftDate

class DeckInfoViewController: UIViewController {
    
    var deck: Deck?
    
    enum State {
        case empty
        case loaded(total: Int, upcoming: Int, nextDate: Date?)
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
        setUpdateTimer()
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
            let all = try context.fetch(allRequest)
            let nextDate = all.first?.nextReview
            state = .loaded(total: allCount, upcoming: upcomingCount, nextDate: nextDate)
        } catch {
            state = .error(error)
        }
    }
    
    private func updateLabelText() {
        switch state {
        case .empty:
            upcomingLabel.text = nil
            totalLabel.text = nil
        case .loaded(let total, let upcoming, let nextDate):
            if upcoming <= 0, let nextDate = nextDate {
                let dateString = nextDate.toRelative(style: RelativeFormatter.defaultStyle(), locale: Locale.current)
                upcomingLabel.text = "Next review: \(dateString)"
            } else {
                upcomingLabel.text = "\(upcoming) reviews ready"
            }
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
    
    private var updateTimer: Timer!
    
    private func setUpdateTimer() {
        updateTimer = Timer(timeInterval: 60, repeats: true) { [weak self] timer in
            if self == nil {
                timer.invalidate()
                return
            }
            self!.update()
        }
        RunLoop.current.add(updateTimer, forMode: .default)
    }
}
