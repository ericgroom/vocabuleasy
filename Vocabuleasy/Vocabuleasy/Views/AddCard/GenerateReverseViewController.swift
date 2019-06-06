//
//  GenerateReverseViewController.swift
//  Vocabuleasy
//
//  Created by Eric Groom on 6/6/19.
//  Copyright © 2019 Eric Groom. All rights reserved.
//

import UIKit

class GenerateReverseViewController: UIViewController {
    var prefersReverseGeneration: Bool {
        return reverseSwitch.isOn
    }
    
    private let reverseSwitch = UISwitch()
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Generate Reverse:"
        label.font = Theme.Fonts.semibold
        label.textColor = Theme.white
        return label
    }()
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = UIStackView.Alignment.center
        stackView.distribution = UIStackView.Distribution.fill
        return stackView
    }()
    
    private let userDefaultsKey = "GenerateReverseCard"
    
    override func viewDidLoad() {
        reverseSwitch.isOn = getReversePreference()
        reverseSwitch.addTarget(self, action: #selector(switchChanged), for: .valueChanged)
        
        stackView.addArrangedSubview(descriptionLabel)
        stackView.addArrangedSubview(reverseSwitch)
        
        view.addSubview(stackView)
        stackView.fill(parent: view, withOffset: Layout.Spacing.standard)
    }
    
    private func getReversePreference() -> Bool {
        if !UserDefaults.standard.keyExists(userDefaultsKey) {
            setReversePreference(newValue: true)
        }
        return UserDefaults.standard.bool(forKey: userDefaultsKey)
    }
    
    private func setReversePreference(newValue: Bool) {
        UserDefaults.standard.set(newValue, forKey: userDefaultsKey)
    }
    
    @objc private func switchChanged() {
        setReversePreference(newValue: reverseSwitch.isOn)
    }
}
