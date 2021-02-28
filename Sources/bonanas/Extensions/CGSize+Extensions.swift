//
//  CGSize+Extensions.swift
//  
//
//  Created by Christopher Weems on 2/1/21.
//

import CoreGraphics

extension CGSize {
    public var maxSide: CGFloat {
        max(width, height)
    }
    
    public var minSide: CGFloat {
        min(width, height)
    }
    
}
