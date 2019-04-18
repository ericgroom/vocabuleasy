//
//  RootViewController.swift
//  Vocabuleasy
//
//  Created by Eric Groom on 4/18/19.
//  Copyright © 2019 Eric Groom. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {
    
    let card = CardBackgroundView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(card)
        
        card.center(on: view)
        card.width(.equal, to: 300)
        card.height(.equal, to: 300)
        
        makeLabels(count: 40)
    }
    
    func makeLabels(count: Int) {
        for i in 0..<count {
            let label = UILabel()

            label.text = "Hello I'm on the card \(i)"
            label.lineBreakMode = .byWordWrapping
            label.backgroundColor = .red
            label.numberOfLines = 2
            card.stackView.addArrangedSubview(label)
        }
    }

}
