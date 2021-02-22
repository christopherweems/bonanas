//  DefaultControllerUserInteractionViewModifier.swift
//  Created by Christopher Weems on 2/19/21

import SwiftUI

struct DefaultControllerUserInteractionViewModifier: ViewModifier {
    @Environment(\.controllerUserInteraction) var controllerUserInteraction
    
    let standardInteractionAllowed: Bool
    
    func body(content: Content) -> some View {
        ControllerInteractionView {
            content
            
        }
        .onAppear { controllerUserInteraction.isEnabled = standardInteractionAllowed }
        .onChange(of: standardInteractionAllowed) { controllerUserInteraction.isEnabled = $0 }
        
    }
    
}

public extension View {
    func allowsDefaultControllerUserInteraction(_ standardInteractionAllowed: Bool) -> some View {
        self.modifier(DefaultControllerUserInteractionViewModifier(standardInteractionAllowed: standardInteractionAllowed))
    }
    
}
