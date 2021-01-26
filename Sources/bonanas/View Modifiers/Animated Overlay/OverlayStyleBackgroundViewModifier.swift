//
//  OverlayStyleBackgroundViewModifier.swift
//  
//
//  Created by Christopher Weems on 1/25/21.
//

import SwiftUI

internal struct OverlayStyleBackgroundViewModifier: ViewModifier {
    let style: OverlayStyle?
    
    func body(content: Content) -> some View {
        let blurRadius: CGFloat
        let saturation: Double
        let opacity: Double
        
        switch style {
        case .blurredBackground:
            blurRadius = 18
            saturation = .phiInverse
            opacity = 0.5
            
        default:
            blurRadius = 0
            saturation = 1
            opacity = 1
            
        }
        
        return content
            .blur(radius: blurRadius)
            .saturation(saturation)
            .opacity(opacity)
    }
    
}


internal extension View {
    func apply(backgroundStyle style: OverlayStyle, if shouldApplyStyle: Bool) -> some View {
        let modifier = OverlayStyleBackgroundViewModifier(style: shouldApplyStyle ? style : nil)
        return self.modifier(modifier)
    }
    
}
