//
//  ImageViewController.swift
//  Vocabuleasy
//
//  Created by Eric Groom on 5/10/19.
//  Copyright © 2019 Eric Groom. All rights reserved.
//

import UIKit

class ImageFieldViewController: UIViewController {
    
    var image: UIImage? {
        get {
            return imageView.image
        }
        set {
            imageView.image = newValue
        }
    }

    private let imageView = UIImageView()
    private let button = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        button.setTitle("Select an image...", for: .normal)
        button.setTitleColor(Theme.iosBlue, for: .normal)
        let imageTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        imageView.addGestureRecognizer(imageTapGestureRecognizer)
        imageView.isUserInteractionEnabled = true
        imageView.contentMode = .scaleAspectFit
        
        button.addTarget(self, action: #selector(imageTapped), for: .touchUpInside)
        
        view.addSubview(button)
        view.addSubview(imageView)
        button.top(to: view.topAnchor, withOffset: Layout.Spacing.standard)
        button.center(on: view, axis: .x)
        imageView.top(to: button.bottomAnchor, withOffset: Layout.Spacing.standard)
        imageView.leading(to: view.leadingAnchor)
        imageView.trailing(to: view.trailingAnchor)
        imageView.bottom(to: view.bottomAnchor)
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


extension ImageFieldViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            self.imageView.image = image
        }
        picker.dismiss(animated: true, completion: nil)
    }
}
