//
//  ScrollableStackView.swift
//  Vocabuleasy
//
//  Created by Eric Groom on 4/18/19.
//  Copyright © 2019 Eric Groom. All rights reserved.
//

import UIKit

class ScrollableStackView: UIView {

    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = UIStackView.Alignment.center
        stackView.distribution = UIStackView.Distribution.fill
        stackView.spacing = 8.0
        return stackView
    }()
    
    // used to allow for vertical padding
    private let wrapperStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        return stackView
    }()
    
    private let scrollView = UIScrollView()
    
    func addArrangedSubview(_ view: UIView) {
        stackView.addArrangedSubview(view)
    }
    
    func removeArrangedSubview(_ view: UIView) {
        stackView.removeArrangedSubview(view)
        view.removeFromSuperview()
    }
    
    private func setup() {
        wrapperStackView.addArrangedSubview(stackView)
        scrollView.addSubview(wrapperStackView)
        addSubview(scrollView)
        
        
        scrollView.fill(parent: self)
        wrapperStackView.fill(parent: scrollView)
        wrapperStackView.width(.equal, to: scrollView)
        wrapperStackView.height(.greaterOrEqual, to: scrollView)
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
