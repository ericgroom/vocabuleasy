//
//  TildeView.swift
//  Vocabuleasy
//
//  Created by Eric Groom on 4/23/19.
//  Copyright © 2019 Eric Groom. All rights reserved.
//

import UIKit

class TildeView: UIView, SymbolView {
    
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
        let path = UIBezierPath()
        
        let startPoint = CGPoint(x: rect.minX+lineWidth, y: rect.midY)
        let midPoint = CGPoint(x: rect.midX, y: rect.midY)
        let endPoint = CGPoint(x: rect.maxX-lineWidth, y: rect.midY)
        
        path.move(to: startPoint)
        
        let controlXUpwards = (startPoint.x + midPoint.x) / 2
        let controlYUpwards = (rect.midY + rect.minY) / 2
        let controlPointUpwards = CGPoint(x: controlXUpwards, y: controlYUpwards)
        path.addQuadCurve(to: midPoint, controlPoint: controlPointUpwards)
        
        let controlXDownards = (midPoint.x + endPoint.x) / 2
        let controlYDownards = (rect.midY + rect.maxY) / 2
        let controlPointDownards = CGPoint(x: controlXDownards, y: controlYDownards)
        path.addQuadCurve(to: endPoint, controlPoint: controlPointDownards)
        
        // rotate around center of shape
        let center = CGPoint(x: rect.midX, y: rect.midY)
        var transform = CGAffineTransform.identity
        transform = transform.translatedBy(x: center.x, y: center.y)
        transform = transform.rotated(by: -CGFloat.pi/8)
        transform = transform.translatedBy(x: -center.x, y: -center.y)
        path.apply(transform)
        
        path.lineWidth = lineWidth
        color.setStroke()
        
        path.stroke()
        
    }
 

}
