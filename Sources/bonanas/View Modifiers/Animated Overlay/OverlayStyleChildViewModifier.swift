//  OverlayStyleChildViewModifier.swift
//  1/25/21


import SwiftUI

internal struct OverlayStyleChildViewModifier: ViewModifier {
    let style: OverlayStyle?
    var animation: Animation? = nil
    
    func body(content: Content) -> some View {
        let scale: CGFloat
        let opacity: Double
        
        switch style {
        case .blurredBackground:
            scale = 1.2
            opacity = 0.0
            
        case .revealFromBehind:
            scale = .phiInverse
            opacity = 0.0
            
        default:
            scale = 1.0
            opacity = 1.0
            
        }
        
        return content
            .opacity(opacity)
            .animation(animation?.speed(sqrt(2)) ?? .default)
            .scaleEffect(scale)
    }
    
}

extension OverlayStyleChildViewModifier {
    func asTransition() -> AnyTransition {
        AnyTransition.modifier(active: OverlayStyleChildViewModifier(style: style),
                               identity: OverlayStyleChildViewModifier(style: nil))
            .animation(animation)
    }
    
}

extension View {
    func apply(childStyle: OverlayStyle, ifNot: Bool) -> some View {
        self.modifier(OverlayStyleChildViewModifier(style: ifNot ? nil : childStyle))
    }
    
}
