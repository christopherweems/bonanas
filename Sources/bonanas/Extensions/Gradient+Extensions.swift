//  Gradient+Extensions.swift
//  Created by Christopher Weems on 3/23/21

import SwiftUI
import unstandard

extension Gradient {
    public static func withStops(@ProtocolTypedArrayBuilder<Stop> stops: () -> [Stop]) -> Gradient {
        .init(stops: stops())
    }
    
}

extension Gradient {
    public func linear(along axis: Axis) -> LinearGradient {
        let startPoint: UnitPoint
        let endPoint: UnitPoint
        
        switch axis {
        case .horizontal:
            startPoint = .leading
            endPoint = .trailing
            
        case .vertical:
            startPoint = .top
            endPoint = .bottom
            
        }
        
        return .init(gradient: self, startPoint: startPoint, endPoint: endPoint)
    }
    
}
