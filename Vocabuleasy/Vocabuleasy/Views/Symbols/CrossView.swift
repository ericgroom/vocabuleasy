//
//  CrossView.swift
//  Vocabuleasy
//
//  Created by Eric Groom on 4/23/19.
//  Copyright © 2019 Eric Groom. All rights reserved.
//

import UIKit

class CrossView: UIView, SymbolView {
    
    var color: UIColor = SymbolViewConstants.defaultColor {
        didSet {
            setNeedsDisplay()
        }
    }
    var lineWidth: CGFloat = SymbolViewConstants.defaultLineWidth {
        didSet {
            setNeedsDisplay()
        }
    }

    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        let forwardSlash: UIBezierPath = {
            let path = UIBezierPath()
            let startPoint = CGPoint(x: rect.minX+lineWidth, y: rect.maxY-lineWidth)
            let endPoint = CGPoint(x: rect.maxX-lineWidth, y: rect.minY+lineWidth)
            path.move(to: startPoint)
            path.addLine(to: endPoint)
            return path
        }()
        let backwardSlash: UIBezierPath = {
            let path = UIBezierPath()
            let startPoint = CGPoint(x: rect.minX+lineWidth, y: rect.minY+lineWidth)
            let endPoint = CGPoint(x: rect.maxX-lineWidth, y: rect.maxY-lineWidth)
            path.move(to: startPoint)
            path.addLine(to: endPoint)
            return path
        }()
        
        forwardSlash.lineWidth = lineWidth
        backwardSlash.lineWidth = lineWidth
        
        color.setStroke()
        forwardSlash.stroke()
        backwardSlash.stroke()
    }
 

}
