//
//  Binding+Extensions.swift
//  
//
//  Created by Christopher Weems on 1/25/21.
//

import SwiftUI

internal extension Binding {
    func nonNil<Wrapped>() -> Binding<Wrapped> where Value == Optional<Wrapped> {
        .init {
            self.wrappedValue!
        } set: {
            self.wrappedValue = $0
        }
    }
    
}
