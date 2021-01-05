//  ScrollViewPositionModifier.swift
//  1/5/21

import SwiftUI

public enum ScrollViewPosition {
    case start
    
}

internal struct ScrollViewPositionModifier<V>: ViewModifier where V : Equatable {
    typealias Position = ScrollViewPosition
    
    let onChange: V
    let scrollTo: Position
    
    func body(content: Content) -> some View {
        ScrollViewReader { scrollView in
            content
                .overlay(
                    Spacer()
                        .id(Position.start)
                        .frame(maxWidth: .infinity, alignment: .leading)
                )
                .onChange(of: onChange) { _ in
                    scrollView.scrollTo(Position.start)
                    
                }
            
        }
        
    }
    
}

public extension View {
    /// must be called on a view within a ScrollView
    func onChange<V: Equatable>(of value: V, scrollTo position: ScrollViewPosition) -> some View {
        self.modifier(ScrollViewPositionModifier(onChange: value, scrollTo: position))
    }
    
}
