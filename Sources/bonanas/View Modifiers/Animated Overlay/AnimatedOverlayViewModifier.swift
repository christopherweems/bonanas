//
//  AnimatedOverlayViewModifier.swift
//  
//
//  Created by Christopher Weems on 1/25/21.
//

import SwiftUI

internal struct AnimatedOverlayViewModifier<Item, OverlayContent>: ViewModifier where Item: Identifiable, OverlayContent : View {
    @State private var presentationMode = _PresentationMode(isPresented: false)
    
    var style: OverlayStyle = .blurredBackground
    
    @Binding var item: Item?
    
    let overlayContent: (Binding<Item>) -> OverlayContent
    
    @ViewBuilder func body(content: Content) -> some View {
        let transitionAnimation = Animation.spring()
        
        ZStack {
            content
                .compositingGroup()
                .apply(backgroundStyle: style, if: isPresentingOverlay)
                .animation(transitionAnimation, value: isPresentingOverlay)
            
            if isPresentingOverlay {
                overlayContent($item.nonNil())
                    .transition(OverlayStyleForegroundViewModifier(style: style).asTransition().animation(transitionAnimation))
                    .onAppear { self.presentationMode.isPresented = true }
                
            }
            
        }
        .environment(\EnvironmentValues.__presentationMode, $presentationMode)
        .onAppear { presentationMode.dismissCallback = { item = nil } }
        
    }
    
}

private extension AnimatedOverlayViewModifier {
    var isPresentingOverlay: Bool {
        item != nil
    }
    
}

public extension View {
    func overlay<Item, Content>(item: Binding<Item?>, @ViewBuilder overlayContent: @escaping (Binding<Item>) -> Content) -> some View where Item : Identifiable, Content : View {
        self.modifier(AnimatedOverlayViewModifier(item: item, overlayContent: overlayContent))
    }
    
}
