//
//  OverlayStyleBackgroundViewModifier.swift
//  
//
//  Created by Christopher Weems on 1/25/21.
//

import SwiftUI
import unstandard

internal struct OverlayStyleBackgroundViewModifier: ViewModifier {
    let style: OverlayStyle?
    
    func body(content: Content) -> some View {
        let blurRadius: CGFloat
        let saturation: Double
        let scale: CGFloat
        let opacity: Double
        
        switch style {
        case .blurredBackground:
            blurRadius = 18
            saturation = .phiInverse
            scale = 1.0
            opacity = 0.5
            
        case .revealFromBehind:
            blurRadius = 14
            saturation = 0
            scale = CGFloat(Double.pi ** 2)
            opacity = 0
            
        default:
            blurRadius = 0
            saturation = 1
            scale = 1
            opacity = 1
            
        }
        
        return content
            .blur(radius: blurRadius)
            .saturation(saturation)
            .scaleEffect(scale)
            .opacity(opacity)
    }
    
}


internal extension View {
    func apply(backgroundStyle style: OverlayStyle, if shouldApplyStyle: Bool) -> some View {
        let modifier = OverlayStyleBackgroundViewModifier(style: shouldApplyStyle ? style : nil)
        return self.modifier(modifier)
    }
    
}
