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
    
    weak var delegate: AddCardDelegate?

    private var cardBottomConstraint: NSLayoutConstraint?
    private let formVC = AddCardFormViewController()
    
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
        

        let card = Card(context: context)
        card.front = self.formVC.frontText
        card.back = self.formVC.backText
        card.id = UUID()
        card.nextReview = Date()
        
        do {
            try context.save()
            self.formVC.clear()
            NotificationService.showSuccessBanner(withText: "Card Saved!")
        } catch let error {
            print("Error saving card: \(error)")
            NotificationService.showErrorBanner(withText: "Error saving card")
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

// - MARK: delegate
protocol AddCardDelegate: class {
    func addCard(withFrontText frontText: String?, andBackText backText: String?)
}
