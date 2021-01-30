//
//  Button+Extensions.swift
//  
//
//  Created by Christopher Weems on 1/29/21.
//

import SwiftUI

public extension Button {
    static func dismiss(action: DismissAction, @ViewBuilder label: () -> Label) -> some View {
        Button(action: action, label: label)
            .disabled(!action.canDismiss)
    }
    
    fileprivate init(action: DismissAction, @ViewBuilder label: () -> Label) {
        self.init(action: action.dismiss, label: label)
    }
    
}
