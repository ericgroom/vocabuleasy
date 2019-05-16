//
//  DeckDetailSettings.swift
//  Vocabuleasy
//
//  Created by Eric Groom on 5/15/19.
//  Copyright © 2019 Eric Groom. All rights reserved.
//

import UIKit

class DeckSettingsViewController: UIViewController {
    
    var deck: Deck? {
        didSet {
            codeField.text = deck?.langCode
        }
    }
    
    let codeField = UITextField()
    let saveButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(savePressed))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Theme.green
        navigationItem.rightBarButtonItem = saveButton
        
        view.addSubview(codeField)
        codeField.placeholder = "language code"
        codeField.center(on: view)
    }
    
    @objc private func savePressed() {
        guard let code = codeField.text else { return }
        let context = ContainerService.shared.persistentContainer.viewContext
        deck?.langCode = code
        do {
            try context.save()
            NotificationService.showSuccessBanner()
        } catch {
            NotificationService.showErrorBanner()
        }
    }
}
