//
//  EditCardViewController.swift
//  Vocabuleasy
//
//  Created by Eric Groom on 5/13/19.
//  Copyright © 2019 Eric Groom. All rights reserved.
//

import UIKit

class EditCardViewController: AddCardViewController {
    
    weak var delegate: EditCardDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(goBack))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(save))
    }
    
    @objc func goBack() {
        self.dismiss(animated: true, completion: nil)
        delegate?.didFinishEditing()
    }
    
    @objc func save() {
        super.saveCard()
        self.goBack()
    }

}

protocol EditCardDelegate: class {
    func didFinishEditing()
}
