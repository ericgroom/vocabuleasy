//
//  AddCardFormViewController.swift
//  Vocabuleasy
//
//  Created by Eric Groom on 5/4/19.
//  Copyright © 2019 Eric Groom. All rights reserved.
//

import UIKit

class AddCardFormViewController: UIViewController {
    
    var frontText: String? {
        get {
            return frontLabel.text
        } set {
            frontLabel.text = newValue
        }
    }
    
    var backText: String? {
        get {
            return backLabel.text
        } set {
            backLabel.text = newValue
        }
    }
    
    private let card = CardBackgroundView()
    private let frontLabel = LabeledTextField()
    private let backLabel = LabeledTextField()
    private let imageView = UIImageView(image: #imageLiteral(resourceName: "Check"))

    override func viewDidLoad() {
        super.viewDidLoad()
        
        frontLabel.name = "Target Word"
        backLabel.name = "Translation"
        
        let imageTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        imageView.addGestureRecognizer(imageTapGestureRecognizer)
        imageView.isUserInteractionEnabled = true
        
        
        card.addArrangedSubview(frontLabel)
        card.addArrangedSubview(backLabel)
        card.addArrangedSubview(imageView)
        view.addSubview(card)
        card.fill(parent: view, withOffset: Layout.Spacing.standard)
        let cardInset = -Layout.Spacing.standard*2
        frontLabel.width(to: card, withOffset: cardInset)
        frontLabel.center(on: card, axis: .x)
        backLabel.width(to: card, withOffset: cardInset)
        backLabel.center(on: card, axis: .x)
        
        imageView.contentMode = .scaleAspectFit
        imageView.height(.lessOrEqual, to: 250)
        imageView.width(to: card, withOffset: cardInset)
    }
    
    func clear() {
        frontLabel.text = ""
        backLabel.text = ""
    }
    
    @objc private func imageTapped() {
        let alert = UIAlertController(title: "Select an image", message: nil, preferredStyle: .actionSheet)
        let galleryAction = UIAlertAction(title: "Gallery", style: .default) { [weak self] (_) in
            let picker = UIImagePickerController()
            picker.sourceType = .photoLibrary
            picker.delegate = self
            self?.present(picker, animated: true, completion: nil)
        }
        let cameraAction = UIAlertAction(title: "Camera", style: .default) { [weak self] (_) in
            let picker = UIImagePickerController()
            picker.sourceType = .camera
            picker.delegate = self
            self?.present(picker, animated: true, completion: nil)
        }
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            alert.addAction(galleryAction)
        }
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            alert.addAction(cameraAction)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
}

extension AddCardFormViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            self.imageView.image = image
            
        }
        picker.dismiss(animated: true, completion: nil)
    }
}
