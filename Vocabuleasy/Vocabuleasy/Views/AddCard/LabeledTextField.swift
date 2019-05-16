//
//  LabeledTextField.swift
//  Vocabuleasy
//
//  Created by Eric Groom on 5/4/19.
//  Copyright © 2019 Eric Groom. All rights reserved.
//

import UIKit

class LabeledTextField: UIView {
    
    var name: String? {
        didSet {
            guard let name = name else { return }
            label.text = name + ":"
        }
    }
    
    var text: String? {
        get {
            return textField.text
        }
        set {
            textField.text = newValue
        }
    }
    
    let textField = UITextView()
    let label = UILabel()
    private let stackView = UIStackView()
    
    
    
    private func setup() {
        textField.layer.shadowColor = UIColor.darkGray.cgColor
        textField.layer.shadowRadius = 4.0
        textField.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
        textField.layer.shadowOpacity = 0.5
        textField.layer.cornerRadius = 4.0
        textField.layer.masksToBounds = false
        textField.backgroundColor = Theme.white
        textField.returnKeyType = .default
        textField.isEditable = true
        textField.isScrollEnabled = false
        textField.font = UIFont(descriptor: .preferredFontDescriptor(withTextStyle: .body), size: 16)
        
        label.font = Theme.Fonts.semibold
        
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 4.0
        stackView.addArrangedSubview(label)
        stackView.addArrangedSubview(textField)

        addSubview(stackView)
        stackView.fill(parent: self)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

}
