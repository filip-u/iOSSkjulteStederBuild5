//
//  browse.swift
//  iOSSkjulteStederBuild5
//
//  Created by Filip Ulatowski on 3/15/15.
//  Copyright (c) 2015 DBH. All rights reserved.
//

import UIKit

class browse: UIView {

    override func drawRect(rect: CGRect)
    {
        let context = UIGraphicsGetCurrentContext()
        CGContextSetLineWidth(context, 2.0)
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let components: [CGFloat] = [1.0, 1.0, 1.0, 1.0]
        let color = CGColorCreate(colorSpace, components)
        CGContextSetStrokeColorWithColor(context, color)
        CGContextMoveToPoint(context, 0, 1)
        CGContextAddLineToPoint(context, 2000,1)
        CGContextStrokePath(context)
        
    }

}
