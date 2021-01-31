//  _PresentationMode.swift
//  1/25/21

import SwiftUI

public struct _PresentationMode {
    public internal(set) var isPresented = true
    internal var dismissCallback: () -> Void = { }
    
    public mutating func dismiss() {
        guard isPresented else { return }
        dismissCallback()
        isPresented = false
        
    }
    
}

public extension EnvironmentValues {
    var _presentationMode: Binding<_PresentationMode> {
        self[_PresentationModeEnvironmentKey.self]
    }
    
    internal var __presentationMode: Binding<_PresentationMode> {
        get { self[_PresentationModeEnvironmentKey.self] }
        set { self[_PresentationModeEnvironmentKey.self] = newValue }
    }
    
}

fileprivate enum _PresentationModeEnvironmentKey: EnvironmentKey {
    static var defaultValue: Binding<_PresentationMode> {
        .constant(.init(isPresented: false))
    }
    
}
