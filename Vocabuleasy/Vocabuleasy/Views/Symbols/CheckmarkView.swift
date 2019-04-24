//
//  CheckmarkView.swift
//  Vocabuleasy
//
//  Created by Eric Groom on 4/23/19.
//  Copyright © 2019 Eric Groom. All rights reserved.
//

import UIKit

class CheckmarkView: UIView, SymbolView {
    
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
        let drawingRect = rect.insetBy(dx: lineWidth, dy: lineWidth)
        let startPoint = CGPoint(x: drawingRect.minX, y: drawingRect.midY)
        let midPoint = CGPoint(x: drawingRect.midX, y: drawingRect.maxY)
        let endPoint = CGPoint(x: drawingRect.maxX, y: drawingRect.minY)
        
        path.move(to: startPoint)
        path.addLine(to: midPoint)
        path.addLine(to: endPoint)
        
        color.setStroke()
        path.lineWidth = lineWidth
        
        path.stroke()
    }

}
