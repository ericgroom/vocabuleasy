//
//  TagTextViewDelegate.swift
//  Vocabuleasy
//
//  Created by Eric Groom on 5/2/19.
//  Copyright © 2019 Eric Groom. All rights reserved.
//

import UIKit

class TagTextViewDelegate: NSObject, UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let nextTag = textField.tag + 1
        if let next = textField.superview?.viewWithTag(nextTag) {
            next.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return false
    }
}
