//  DismissAction.swift
//  1/29/21

import SwiftUI

public struct DismissAction {
    private let _canDismiss: () -> Bool
    
    public var canDismiss: Bool { _canDismiss() }
    public let dismiss: () -> Void
    
    public func callAsFunction() {
        dismiss()
    }
    
    public init(canDismiss: @autoclosure @escaping () -> Bool, dismiss: @escaping () -> Void) {
        self._canDismiss = canDismiss
        self.dismiss = dismiss
        
    }
    
}

extension DismissAction {
    public init(isPresented: Binding<Bool>) {
        _canDismiss = { isPresented.wrappedValue }
        dismiss = { isPresented.wrappedValue = false }
        
    }
    
}
