//
//  RootViewController.swift
//  Vocabuleasy
//
//  Created by Eric Groom on 4/18/19.
//  Copyright © 2019 Eric Groom. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {
    
    var reviewVC: ReviewViewController?
    private let reviewSegueId = "RootReviewEmbed"

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Theme.green
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == reviewSegueId {
            self.reviewVC = segue.destination as! ReviewViewController
        }
    }

}
