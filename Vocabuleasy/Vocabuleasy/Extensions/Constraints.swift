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
    
    func fill(parent: UIView, withOffset offset: CGFloat = 0.0) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.topAnchor.constraint(equalTo: parent.topAnchor, constant: offset).isActive = true
        self.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: offset).isActive = true
        self.bottomAnchor.constraint(equalTo: parent.bottomAnchor, constant: -offset).isActive = true
        self.trailingAnchor.constraint(equalTo: parent.trailingAnchor, constant: -offset).isActive = true
    }
    
    func fillIfNeeded(parent: UIView, withOffset offset: CGFloat = 0.0) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.topAnchor.constraint(lessThanOrEqualTo: parent.topAnchor, constant: offset).isActive = true
        self.leadingAnchor.constraint(lessThanOrEqualTo: parent.leadingAnchor, constant: offset).isActive = true
        self.bottomAnchor.constraint(lessThanOrEqualTo: parent.bottomAnchor, constant: -offset).isActive = true
        self.trailingAnchor.constraint(lessThanOrEqualTo: parent.trailingAnchor, constant: -offset).isActive = true
        self.centerXAnchor.constraint(equalTo: parent.centerXAnchor).isActive = true
        self.centerYAnchor.constraint(equalTo: parent.centerYAnchor).isActive = true
    }
    
    func fillOrExtend(parent: UIView, withOffset offset: CGFloat = 0.0) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.topAnchor.constraint(greaterThanOrEqualTo: parent.topAnchor, constant: offset).isActive = true
        self.leadingAnchor.constraint(greaterThanOrEqualTo: parent.leadingAnchor, constant: offset).isActive = true
        self.bottomAnchor.constraint(greaterThanOrEqualTo: parent.bottomAnchor, constant: -offset).isActive = true
        self.trailingAnchor.constraint(greaterThanOrEqualTo: parent.trailingAnchor, constant: -offset).isActive = true
        self.centerXAnchor.constraint(equalTo: parent.centerXAnchor).isActive = true
        self.centerYAnchor.constraint(equalTo: parent.centerYAnchor).isActive = true
    }
    
    // - MARK: size
    
    func width(_ mode: Mode = .equal, to parent: UIView) {
        self.translatesAutoresizingMaskIntoConstraints = false
        switch mode {
        case .equal:
            self.widthAnchor.constraint(equalTo: parent.widthAnchor).isActive = true
        case .greaterOrEqual:
            self.widthAnchor.constraint(greaterThanOrEqualTo: parent.widthAnchor).isActive = true
        case .lessOrEqual:
            self.widthAnchor.constraint(lessThanOrEqualTo: parent.widthAnchor).isActive = true
        }
        
    }
    
    func height(_ mode: Mode = .equal, to parent: UIView) {
        self.translatesAutoresizingMaskIntoConstraints = false
        switch mode {
        case .equal:
            self.heightAnchor.constraint(equalTo: parent.heightAnchor).isActive = true
        case .greaterOrEqual:
            self.heightAnchor.constraint(greaterThanOrEqualTo: parent.heightAnchor).isActive = true
        case .lessOrEqual:
            self.heightAnchor.constraint(lessThanOrEqualTo: parent.heightAnchor).isActive = true
        }
        
    }
    
    @discardableResult
    func width(_ mode: Mode = .equal, to constant: CGFloat) -> NSLayoutConstraint {
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
        c.isActive = true
        return c
        
    }
    
    @discardableResult
    func height(_ mode: Mode = .equal, to constant: CGFloat) -> NSLayoutConstraint {
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
        c.isActive = true
        return c
    }
    
    // - MARK: align
    
    func center(on parent: UIView, axis: Axis = .both) {
        self.translatesAutoresizingMaskIntoConstraints = false
        if axis == .x || axis == .both {
            self.centerXAnchor.constraint(greaterThanOrEqualTo: parent.centerXAnchor).isActive = true
        }
        if axis == .y || axis == .both {
            self.centerYAnchor.constraint(greaterThanOrEqualTo: parent.centerYAnchor).isActive = true
        }
    }
    
    @discardableResult
    func top(to anchor: NSLayoutYAxisAnchor, withOffset offset: CGFloat = 0.0) -> NSLayoutConstraint {
        self.translatesAutoresizingMaskIntoConstraints = false
        let constraint = self.topAnchor.constraint(equalTo: anchor, constant: offset)
        constraint.isActive = true
        return constraint
    }
    
    @discardableResult
    func bottom(to anchor: NSLayoutYAxisAnchor, withOffset offset: CGFloat = 0.0)  -> NSLayoutConstraint {
        self.translatesAutoresizingMaskIntoConstraints = false
        let constraint =  self.bottomAnchor.constraint(equalTo: anchor, constant: offset)
        constraint.isActive = true
        return constraint
    }
    
    @discardableResult
    func leading(to anchor: NSLayoutXAxisAnchor, withOffset offset: CGFloat = 0.0) -> NSLayoutConstraint {
        self.translatesAutoresizingMaskIntoConstraints = false
        let constraint =  self.leadingAnchor.constraint(equalTo: anchor, constant: offset)
        constraint.isActive = true
        return constraint
    }
    
    @discardableResult
    func trailing(to anchor: NSLayoutXAxisAnchor, withOffset offset: CGFloat = 0.0) -> NSLayoutConstraint {
        self.translatesAutoresizingMaskIntoConstraints = false
        let constraint =  self.trailingAnchor.constraint(equalTo: anchor, constant: offset)
        constraint.isActive = true
        return constraint
    }
}
