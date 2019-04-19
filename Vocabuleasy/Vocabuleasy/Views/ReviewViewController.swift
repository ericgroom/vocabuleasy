//
//  ReviewViewController.swift
//  Vocabuleasy
//
//  Created by Eric Groom on 4/18/19.
//  Copyright © 2019 Eric Groom. All rights reserved.
//

import UIKit

class ReviewViewController: UIViewController {
    
    private var cardController: CardViewController?
    @IBOutlet private var flipButton: UIButton?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Theme.green
        flipButton?.setTitle("flip", for: .normal)
        flipButton?.backgroundColor = Theme.purple
        flipButton?.tintColor = .white
        flipButton?.layer.cornerRadius = 8.0
        flipButton?.addTarget(self, action: #selector(flipButtonPressed), for: .touchUpInside)
    }
    
    @objc func flipButtonPressed() {
        cardController?.flipCard()
    }
    private let cardControllerSegueId = "ReviewCardEmbed"
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == cardControllerSegueId {
            cardController = segue.destination as! CardViewController
        }
    }

}
