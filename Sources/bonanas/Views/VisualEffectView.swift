//  VisualEffectView.swift
//  Created by Christopher Weems on 2/23/21

#if canImport(UIKit)
import SwiftUI
@_exported import UIKit.UIVisualEffect
import UIKit

public struct VisualEffectView: UIViewRepresentable {
    public let effect: UIVisualEffect
    
    public func makeUIView(context: Context) -> UIVisualEffectView {
        let view = UIVisualEffectView(effect: self.effect)
        return view
    }
    
    public func updateUIView(_ effectView: UIVisualEffectView, context: Context) {
        effectView.effect = effect
        
    }
    
    public init(effect: UIVisualEffect) {
        self.effect = effect
        
    }
    
    public init(blurEffect style: UIBlurEffect.Style) {
        self.effect = UIBlurEffect(style: style)
        
    }
    
}

#endif
