//
//  AnyTransition+Extensions.swift
//
//
//  Created by Christopher Weems on 10/1/20.
//

import SwiftUI

public extension AnyTransition {
    static func asymmetric(_ insertionAndRemoval: (Bool) -> AnyTransition) -> AnyTransition {
        .asymmetric(insertion: insertionAndRemoval(true), removal: insertionAndRemoval(false))
    }
    
}
