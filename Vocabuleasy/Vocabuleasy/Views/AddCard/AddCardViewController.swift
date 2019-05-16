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
    
    enum Mode {
        case add
        case edit(Card)
    }
    
    var deck: Deck?
    
    var mode: Mode? {
        didSet {
            guard let mode = mode else { return }
            updateView(for: mode)
        }
    }

    private var cardBottomConstraint: NSLayoutConstraint?
    private let formVC = CardFormViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Theme.green
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveCard))
        
        formVC.delegate = self

        embed(formVC)
        formVC.view.top(to: view.topAnchor)
        formVC.view.leading(to: view.leadingAnchor)
        formVC.view.trailing(to: view.trailingAnchor)
        cardBottomConstraint = formVC.view.bottom(to: view.bottomAnchor)
        
        configureKeyboardListeners()
    }
    
    @objc func saveCard() {
        let context = ContainerService.shared.persistentContainer.viewContext
        guard let mode = mode, let deck = deck else { return }
        switch mode {
        case .add:
            let card = Card(context: context)
            card.id = UUID()
            card.nextReview = Date()
            deck.addToCards(card)
            card.data = CardFieldData(context: context)
            card.data?.targetWord = formVC.frontText
            card.data?.translation = formVC.backText
            card.data?.example = formVC.exampleText
            card.data?.photo = formVC.image?.pngData()
        case .edit(let card):
            if card.data == nil {
                card.data = CardFieldData(context: context)
            }
            card.data!.targetWord = formVC.frontText
            card.data!.translation = formVC.backText
            card.data!.example = formVC.exampleText
            card.data!.photo = formVC.image?.pngData()
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
    
    private func updateView(for mode: Mode) {
        switch mode {
        case .add:
            formVC.clear()
        case .edit(let card):
            guard let data = card.data else { return }
            formVC.frontText = data.targetWord
            formVC.backText = data.translation
            formVC.exampleText = data.example
            if let imageData = data.photo {
                formVC.image = UIImage(data: imageData)
            }
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

extension AddCardViewController: CardFormDelegate {
    func generateExampleTapped(for targetWord: String) {
        let langCode = deck?.langCode ?? "eng"
        APIExampleSentenceProvider.shared.getExampleSentence(for: targetWord, lang: langCode) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let sentences):
                self.formVC.exampleText = sentences.randomElement()
            case .failure(_):
                NotificationService.showErrorBanner(withText: "Unable to fetch examples")
            }
        }
    }
}
