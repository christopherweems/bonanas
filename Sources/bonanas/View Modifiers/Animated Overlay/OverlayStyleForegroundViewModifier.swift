//
//  OverlayStyleForegroundViewModifier.swift
//  
//
//  Created by Christopher Weems on 1/25/21.
//

import SwiftUI

internal struct OverlayStyleForegroundViewModifier: ViewModifier {
    let style: OverlayStyle?
    
    func body(content: Content) -> some View {
        let scale: CGFloat
        let opacity: Double
        
        switch style {
        case .blurredBackground:
            scale = 1.2
            opacity = 0.0
            
        default:
            scale = 1.0
            opacity = 1.0
            
        }
        
        return content
            .scaleEffect(scale)
            .opacity(opacity)
    }
    
}

extension OverlayStyleForegroundViewModifier {
    func asTransition() -> AnyTransition {
        AnyTransition.modifier(active: OverlayStyleForegroundViewModifier(style: style),
                               identity: OverlayStyleForegroundViewModifier(style: nil))
    }
    
}

extension View {
    func apply(foregroundStyle: OverlayStyle, ifNot: Bool) -> some View {
        self.modifier(OverlayStyleForegroundViewModifier(style: ifNot ? nil : foregroundStyle))
    }
    
}
