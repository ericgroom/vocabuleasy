//
//  Constraints.swift
//  Vocabuleasy
//
//  Created by Eric Groom on 4/18/19.
//  Copyright © 2019 Eric Groom. All rights reserved.
//

import UIKit

enum Mode {
    case equal, greaterOrEqual, lessOrEqual
}

enum Axis {
    case x, y, both
}

extension UIView {
    
    // - MARK: fills
    
    @discardableResult
    func fill(parent: UIView, withOffset offset: CGFloat = 0.0, activate: Bool = true) -> [NSLayoutConstraint] {
        self.translatesAutoresizingMaskIntoConstraints = false
        let top = self.topAnchor.constraint(equalTo: parent.topAnchor, constant: offset)
        let leading = self.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: offset)
        let bottom = self.bottomAnchor.constraint(equalTo: parent.bottomAnchor, constant: -offset)
        let trailing = self.trailingAnchor.constraint(equalTo: parent.trailingAnchor, constant: -offset)
        let constraints = [top, leading, bottom, trailing]
        if activate {
            NSLayoutConstraint.activate(constraints)
        }
        return constraints
    }
    
    // - MARK: size
    
    @discardableResult
    func width(_ mode: Mode = .equal, to parent: UIView, withOffset offset: CGFloat = 0.0, priority: UILayoutPriority? = nil, activate: Bool = true) -> NSLayoutConstraint {
        self.translatesAutoresizingMaskIntoConstraints = false
        let c: NSLayoutConstraint
        switch mode {
        case .equal:
            c = self.widthAnchor.constraint(equalTo: parent.widthAnchor, constant: offset)
        case .greaterOrEqual:
            c = self.widthAnchor.constraint(greaterThanOrEqualTo: parent.widthAnchor, constant: offset)
        case .lessOrEqual:
            c = self.widthAnchor.constraint(lessThanOrEqualTo: parent.widthAnchor, constant: offset)
        }
        if let priority = priority {
            c.priority = priority
        }
        if activate {
            c.isActive = true
        }
        return c
    }
    
    @discardableResult
    func width(_ mode: Mode = .equal, to constant: CGFloat, priority: UILayoutPriority? = nil, activate: Bool = true) -> NSLayoutConstraint {
        self.translatesAutoresizingMaskIntoConstraints = false
        let c: NSLayoutConstraint
        switch mode {
        case .equal:
            c = self.widthAnchor.constraint(equalToConstant: constant)
        case .greaterOrEqual:
            c = self.widthAnchor.constraint(greaterThanOrEqualToConstant: constant)
        case .lessOrEqual:
            c = self.widthAnchor.constraint(lessThanOrEqualToConstant: constant)
        }
        if let priority = priority {
            c.priority = priority
        }
        if activate {
            c.isActive = true
        }
        return c
        
    }
    
    @discardableResult
    func width(_ mode: Mode = .equal, to dimension: NSLayoutDimension, withMultiplier multiplier: CGFloat, withOffset offset: CGFloat = 0.0, priority: UILayoutPriority? = nil, activate: Bool = true) -> NSLayoutConstraint {
        self.translatesAutoresizingMaskIntoConstraints = false
        let c: NSLayoutConstraint
        switch mode {
        case .equal:
            c = self.widthAnchor.constraint(equalTo: dimension, multiplier: multiplier, constant: offset)
        case .greaterOrEqual:
            c = self.widthAnchor.constraint(greaterThanOrEqualTo: dimension, multiplier: multiplier, constant: offset)
        case .lessOrEqual:
            c = self.widthAnchor.constraint(greaterThanOrEqualTo: dimension, multiplier: multiplier, constant: offset)
        }
        if let priority = priority {
            c.priority = priority
        }
        if activate {
            c.isActive = true
        }
        return c
    }
    
    
    @discardableResult
    func height(_ mode: Mode = .equal, to parent: UIView, withOffset offset: CGFloat = 0.0, priority: UILayoutPriority? = nil, activate: Bool = true) -> NSLayoutConstraint {
        self.translatesAutoresizingMaskIntoConstraints = false
        let c: NSLayoutConstraint
        switch mode {
        case .equal:
            c = self.heightAnchor.constraint(equalTo: parent.heightAnchor, constant: offset)
        case .greaterOrEqual:
            c = self.heightAnchor.constraint(greaterThanOrEqualTo: parent.heightAnchor, constant: offset)
        case .lessOrEqual:
            c = self.heightAnchor.constraint(lessThanOrEqualTo: parent.heightAnchor, constant: offset)
        }
        if let priority = priority {
            c.priority = priority
        }
        if activate {
            c.isActive = true
        }
        return c
    }
    
    @discardableResult
    func height(_ mode: Mode = .equal, to constant: CGFloat, priority: UILayoutPriority? = nil, activate: Bool = true) -> NSLayoutConstraint {
        self.translatesAutoresizingMaskIntoConstraints = false
        let c: NSLayoutConstraint
        switch mode {
        case .equal:
            c = self.heightAnchor.constraint(equalToConstant: constant)
        case .greaterOrEqual:
            c = self.heightAnchor.constraint(greaterThanOrEqualToConstant: constant)
        case .lessOrEqual:
            c = self.heightAnchor.constraint(lessThanOrEqualToConstant: constant)
        }
        if let priority = priority {
            c.priority = priority
        }
        if activate {
            c.isActive = true
        }
        return c
    }
    
    @discardableResult
    func height(_ mode: Mode = .equal, to dimension: NSLayoutDimension, withMultiplier multiplier: CGFloat, withOffset offset: CGFloat = 0.0, priority: UILayoutPriority? = nil, activate: Bool = true) -> NSLayoutConstraint {
        self.translatesAutoresizingMaskIntoConstraints = false
        let c: NSLayoutConstraint
        switch mode {
        case .equal:
            c = self.heightAnchor.constraint(equalTo: dimension, multiplier: multiplier, constant: offset)
        case .greaterOrEqual:
            c = self.heightAnchor.constraint(greaterThanOrEqualTo: dimension, multiplier: multiplier, constant: offset)
        case .lessOrEqual:
            c = self.heightAnchor.constraint(greaterThanOrEqualTo: dimension, multiplier: multiplier, constant: offset)
        }
        if let priority = priority {
            c.priority = priority
        }
        if activate {
            c.isActive = true
        }
        return c
    }
    
    // - MARK: align
    
    @discardableResult
    func center(on parent: UIView, axis: Axis = .both, priority: UILayoutPriority? = nil, activate: Bool = true) -> [NSLayoutConstraint] {
        self.translatesAutoresizingMaskIntoConstraints = false
        var constraints: [NSLayoutConstraint] = []
        if axis == .x || axis == .both {
            let c = self.centerXAnchor.constraint(greaterThanOrEqualTo: parent.centerXAnchor)
            constraints.append(c)
        }
        if axis == .y || axis == .both {
            let c = self.centerYAnchor.constraint(greaterThanOrEqualTo: parent.centerYAnchor)
            constraints.append(c)
        }
        if let priority = priority {
            constraints.forEach { $0.priority = priority }
        }
        if activate {
            NSLayoutConstraint.activate(constraints)
        }
        return constraints
    }
    
    @discardableResult
    func top(to anchor: NSLayoutYAxisAnchor, withOffset offset: CGFloat = 0.0, priority: UILayoutPriority? = nil, activate: Bool = true) -> NSLayoutConstraint {
        self.translatesAutoresizingMaskIntoConstraints = false
        let c = self.topAnchor.constraint(equalTo: anchor, constant: offset)
        if let priority = priority {
            c.priority = priority
        }
        if activate {
            c.isActive = true
        }
        return c
    }
    
    @discardableResult
    func bottom(to anchor: NSLayoutYAxisAnchor, withOffset offset: CGFloat = 0.0, priority: UILayoutPriority? = nil, activate: Bool = true)  -> NSLayoutConstraint {
        self.translatesAutoresizingMaskIntoConstraints = false
        let c = self.bottomAnchor.constraint(equalTo: anchor, constant: -offset)
        if let priority = priority {
            c.priority = priority
        }
        if activate {
            c.isActive = true
        }
        return c
    }
    
    @discardableResult
    func leading(to anchor: NSLayoutXAxisAnchor, withOffset offset: CGFloat = 0.0, priority: UILayoutPriority? = nil, activate: Bool = true) -> NSLayoutConstraint {
        self.translatesAutoresizingMaskIntoConstraints = false
        let c = self.leadingAnchor.constraint(equalTo: anchor, constant: offset)
        if let priority = priority {
            c.priority = priority
        }
        if activate {
            c.isActive = true
        }
        return c
    }
    
    @discardableResult
    func trailing(to anchor: NSLayoutXAxisAnchor, withOffset offset: CGFloat = 0.0, priority: UILayoutPriority? = nil, activate: Bool = true) -> NSLayoutConstraint {
        self.translatesAutoresizingMaskIntoConstraints = false
        let c = self.trailingAnchor.constraint(equalTo: anchor, constant: -offset)
        if let priority = priority {
            c.priority = priority
        }
        if activate {
            c.isActive = true
        }
        return c
    }
}
