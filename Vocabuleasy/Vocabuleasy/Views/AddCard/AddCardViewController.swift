//
//  AddCardViewController.swift
//  Vocabuleasy
//
//  Created by Eric Groom on 4/27/19.
//  Copyright © 2019 Eric Groom. All rights reserved.
//

import UIKit

class AddCardViewController: KeyboardViewController {

    private let card = CardViewController()
    private var cardBottomConstraint: NSLayoutConstraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Theme.green

        embed(card)
        card.view.top(to: view.topAnchor, withOffset: Layout.Spacing.standard)
        card.view.leading(to: view.leadingAnchor, withOffset: Layout.Spacing.standard)
        card.view.trailing(to: view.trailingAnchor, withOffset: Layout.Spacing.standard)
        cardBottomConstraint = card.view.bottom(to: view.bottomAnchor, withOffset: Layout.Spacing.standard)
        
        let front = CardInputFieldBuilder().addTextInputField(called: "test").addTextInputField(called: "test2").build()
        card.cardFields = CardFields(frontFields: front, backFields: [])
        configureKeyboardListeners()
    }
    
    func configureKeyboardListeners() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(sender: Notification) {
        guard let info = sender.userInfo, let keyboardRect = info["UIKeyboardFrameBeginUserInfoKey"] as? CGRect else { return }
        cardBottomConstraint?.constant = -keyboardRect.height - Layout.Spacing.standard
        if let animationDuration = info["UIKeyboardAnimationDurationUserInfoKey"] as? TimeInterval {
            UIView.animate(withDuration: animationDuration) { self.view.layoutIfNeeded() }
        }
    }
    
    @objc func keyboardWillHide(sender: Notification) {
        guard let info = sender.userInfo else { return }
        cardBottomConstraint?.constant = -Layout.Spacing.standard
        if let animationDuration = info["UIKeyboardAnimationDurationUserInfoKey"] as? TimeInterval {
            UIView.animate(withDuration: animationDuration) { self.view.layoutIfNeeded() }
        }
    }
    


}
