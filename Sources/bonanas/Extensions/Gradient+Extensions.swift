//  Gradient+Extensions.swift
//  Created by Christopher Weems on 3/23/21

import SwiftUI
import unstandard

extension Gradient {
    public static func withStops(@ProtocolTypedArrayBuilder<Stop> _ stops: () -> [Stop]) -> Gradient {
        .init(stops: stops())
    }
    
}

public extension Gradient {
    typealias OpacityStop = (opacity: Double, location: CGFloat)
    
    static func withOpacityStops(@ProtocolTypedArrayBuilder<OpacityStop> _ opacityStops: () -> [OpacityStop]) -> Gradient {
        let stops: [Gradient.Stop] = opacityStops()
            .map { .init(color: .black.opacity($0.opacity), location: $0.location) }
        
        return Gradient(stops: stops)
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
