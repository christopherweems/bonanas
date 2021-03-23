//  HintTextOverlay.swift
//  Created by Christopher Weems on 2/3/21

import SwiftUI
import unstandard

fileprivate struct HintTextOverlay: ViewModifier {
    let text: Text
    let helpText: Text?
    
    let textCase: Text.Case?
    
    func body(content: Content) -> some View {
        ZStack(alignment: .bottom) {
            #if !os(tvOS)
            content
            
            #else
            content
                .padding(.bottom, 60)
            
            #endif
            
            text
                .font(font)
                .textCase(textCase)
                .help(helpText ?? Text(""))
                .padding(.vertical, 4)
                .fixedSize()
            
        }
        
    }
    
}

fileprivate extension HintTextOverlay {
    @SingleResult var font: Font {
        switch textCase {
        case .uppercase:
            Font.footnote.lowercaseSmallCaps()
            
        default:
            Font.footnote
            
        }
    }
    
}

public extension View {
    func hintText(_ hintText: Text, help: Text? = nil, textCase: Text.Case? = .uppercase) -> some View {
        self.modifier(HintTextOverlay(text: hintText, helpText: help, textCase: textCase))
    }
    
    func hintText(_ hintText: Text, help helpText: String, textCase: Text.Case? = .uppercase) -> some View {
        self.modifier(HintTextOverlay(text: hintText, helpText: Text(helpText), textCase: textCase))
    }
    
    func hintText(_ hintText: String, help: Text? = nil, textCase: Text.Case? = .uppercase) -> some View {
        self.hintText(Text(hintText), help: help, textCase: textCase)
    }
    
    func hintText(_ hintText: String, help helpText: String, textCase: Text.Case? = .uppercase) -> some View {
        self.hintText(Text(hintText), help: Text(helpText), textCase: textCase)
    }
    
}

public extension View {
    func hintText<Label>(_ hintTextView: Label, help: Text? = nil,
                     textCase: Text.Case? = .uppercase) -> some View where Label : View, Label.Body == Text {
        self.hintText(hintTextView.body, help: help, textCase: textCase)
    }
    
}
