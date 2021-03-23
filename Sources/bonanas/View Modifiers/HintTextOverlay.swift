//  HintTextOverlay.swift
//  Created by Christopher Weems on 2/3/21

import SwiftUI

fileprivate struct HintTextOverlay: ViewModifier {
    let text: Text
    let helpText: Text?
    
    func body(content: Content) -> some View {
        ZStack(alignment: .bottom) {
            #if !os(tvOS)
            content
            
            #else
            content
                .padding(.bottom, 60)
            
            #endif
            
            text
                .font(.footnote.lowercaseSmallCaps())
                .textCase(.uppercase)
                .help(helpText ?? Text(""))
                .padding(.vertical, 4)
                .fixedSize()
            
        }
        
    }
}

public extension View {
    func hintText(_ hintText: Text, help: Text? = nil) -> some View {
        self.modifier(HintTextOverlay(text: hintText, helpText: help))
    }
    
    func hintText(_ hintText: Text, help helpText: String) -> some View {
        self.modifier(HintTextOverlay(text: hintText, helpText: Text(helpText)))
    }
    
    func hintText(_ hintText: String, help: Text? = nil) -> some View {
        self.hintText(Text(hintText), help: help)
    }
    
    func hintText(_ hintText: String, help helpText: String) -> some View {
        self.hintText(Text(hintText), help: Text(helpText))
    }
    
}
