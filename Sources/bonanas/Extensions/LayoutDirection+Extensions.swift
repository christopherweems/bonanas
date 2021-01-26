//
//  LayoutDirection+Extensions.swift
//  
//
//  Created by Christopher Weems on 1/26/21.
//

import SwiftUI

extension LayoutDirection {
    public func reversed(_ reversed: Bool) -> LayoutDirection {
        guard reversed else { return self }
        
        switch self {
        case .leftToRight:
            return .rightToLeft
            
        case .rightToLeft:
            return .leftToRight
            
        @unknown default:
            return self
        }
    }
    
}
