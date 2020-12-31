//  View+Extensions.swift
//  12/30/20

import SwiftUI


// MARK: - Platform specific modifiers

public extension View {
    func modifier<Result>(platform: Platform, _ mods: (Self) -> Result) -> AnyView where Result : View {
        guard platform.contains(.current) else { return AnyView(erasing: self) }
        return AnyView(erasing: mods(self))
    }
    
}
