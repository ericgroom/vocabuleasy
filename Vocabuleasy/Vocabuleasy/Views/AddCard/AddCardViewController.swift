//
//  AddCardViewController.swift
//  Vocabuleasy
//
//  Created by Eric Groom on 4/27/19.
//  Copyright © 2019 Eric Groom. All rights reserved.
//

import UIKit
import NotificationBannerSwift
import CoreData

class AddCardViewController: KeyboardViewController {
    
    var card: Card? {
        didSet {
            updateView(with: card)
        }
    }
    var deck: Deck?

    private var cardBottomConstraint: NSLayoutConstraint?
    private let formVC = CardFormViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Theme.green
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveCard))

        embed(formVC)
        formVC.view.top(to: view.topAnchor)
        formVC.view.leading(to: view.leadingAnchor)
        formVC.view.trailing(to: view.trailingAnchor)
        cardBottomConstraint = formVC.view.bottom(to: view.bottomAnchor)
        
        configureKeyboardListeners()
    }
    
    @objc func saveCard() {
        let context = ContainerService.shared.persistentContainer.viewContext
        
        // create card if it is not set for editing
        if card == nil {
            card = Card(context: context)
            card!.id = UUID()
            card!.nextReview = Date()
            deck?.addToCards(card!)
        }
        if let card = card, card.data == nil {
            card.data = CardFieldData(context: context)
        }
        let cardData = card!.data!
        
        // set fields if they have been changed
        if cardData.targetWord != formVC.frontText {
            cardData.targetWord = formVC.frontText
        }
        if cardData.translation != formVC.frontText {
            cardData.translation = formVC.backText
        }
        if cardData.example != formVC.exampleText {
            cardData.example = formVC.exampleText
        }
        if cardData.photo != formVC.image?.pngData() {
            cardData.photo = formVC.image?.pngData()
        }

        do {
            try context.save()
            self.formVC.clear()
            NotificationService.showSuccessBanner(withText: "Card Saved!")
        } catch let error {
            print("Error saving card: \(error)")
            NotificationService.showErrorBanner(withText: "Error saving card")
        }
        
    }
    
    private func updateView(with card: Card?) {
        guard let card = card, let data = card.data else {
            formVC.clear()
            return
        }
        formVC.frontText = data.targetWord
        formVC.backText = data.translation
        formVC.exampleText = data.example
        if let imageData = data.photo {
            formVC.image = UIImage(data: imageData)
        }
    }

    // - MARK: Resizing view for keyboard
    
    private func configureKeyboardListeners() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func keyboardWillShow(sender: Notification) {
        guard let info = sender.userInfo, let keyboardRect = info["UIKeyboardFrameBeginUserInfoKey"] as? CGRect else { return }
        cardBottomConstraint?.constant = -keyboardRect.height
        if let animationDuration = info["UIKeyboardAnimationDurationUserInfoKey"] as? TimeInterval {
            UIView.animate(withDuration: animationDuration) { self.view.layoutIfNeeded() }
        }
    }
    
    @objc private func keyboardWillHide(sender: Notification) {
        guard let info = sender.userInfo else { return }
        cardBottomConstraint?.constant = 0
        if let animationDuration = info["UIKeyboardAnimationDurationUserInfoKey"] as? TimeInterval {
            UIView.animate(withDuration: animationDuration) { self.view.layoutIfNeeded() }
        }
    }
}
