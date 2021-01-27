//
//  AnimatedOverlayViewModifier.swift
//  
//
//  Created by Christopher Weems on 1/25/21.
//

import SwiftUI

internal struct AnimatedOverlayViewModifier<Item, OverlayContent>: ViewModifier where Item: Identifiable, OverlayContent : View {
    @State private var presentationMode = _PresentationMode(isPresented: false)
    @State private var presentingStyle: OverlayStyle?
    
    var style: OverlayStyle = .default
    
    @Binding var item: Item?
    
    var onDismiss: (() -> Void)? = nil
    
    let overlayContent: (Binding<Item>) -> OverlayContent
    
    @ViewBuilder func body(content: Content) -> some View {
        let transitionAnimation = Animation.spring()
        let style = presentingStyle ?? self.style
        
        ZStack {
            content
                .compositingGroup()
                .apply(backgroundStyle: style, if: isPresentingOverlay)
                .animation(transitionAnimation, value: isPresentingOverlay)
                .sheet(item: sheetItem, onDismiss: { presentationMode.dismiss() }) { _ in
                    overlayContent($item.nonNil())
                        .onAppear { self.presentationMode.isPresented = true }
                        .environment(\EnvironmentValues.__presentationMode, $presentationMode)
                    
                }
            
            if isPresentingOverlay && style != .sheet {
                overlayContent($item.nonNil())
                    .transition(OverlayStyleForegroundViewModifier(style: style, animation: transitionAnimation).asTransition())
                    .onAppear { self.presentationMode.isPresented = true }
                
            }
            
        }
        .environment(\EnvironmentValues.__presentationMode, $presentationMode)
        .onChange(of: presentationMode.isPresented) { isPresented in
            presentingStyle = isPresented ? style : nil
            
        }
        .onAppear {
            presentationMode.dismissCallback = {
                item = nil
                onDismiss?()
                
            }
        }
        
    }
    
}

private extension AnimatedOverlayViewModifier {
    var isPresentingOverlay: Bool {
        item != nil
    }
    
    var sheetItem: Binding<Item?> {
        Binding {
            (presentingStyle ?? style) == .sheet ? item : nil
        } set: {
            item = $0
        }
    }
    
}


// MARK: - `View.overlay(item:style:_:)`

public extension View {
    func overlay<Item, Content>(item: Binding<Item?>, style: OverlayStyle = .default, onDismiss: (() -> Void)? = nil,
                                @ViewBuilder overlayContent: @escaping (Binding<Item>) -> Content) -> some View where Item : Identifiable, Content : View {
        self.modifier(AnimatedOverlayViewModifier(style: style, item: item, onDismiss: onDismiss, overlayContent: overlayContent))
    }
    
}
