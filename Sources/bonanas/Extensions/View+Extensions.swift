//  View+Extensions.swift
//  12/30/20

import SwiftUI
import unstandard

// MARK: - Platform specific modifiers

public extension View {
    func modifier<Result>(platform platforms: Platform..., modifications: (Self) -> Result) -> AnyView where Result : View {
        guard platforms.union().contains(.current) else { return AnyView(erasing: self) }
        return AnyView(erasing: modifications(self))
    }
    
}
