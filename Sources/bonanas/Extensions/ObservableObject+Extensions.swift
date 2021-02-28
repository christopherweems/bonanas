//  ObservableObject+Extensions.swift
//  Created by Christopher Weems on 2/27/21

import SwiftUI

extension ObservableObject {
    public subscript<Value>(binding keyPath: ReferenceWritableKeyPath<Self, Value>) -> Binding<Value> {
        .init {
            self[keyPath: keyPath]
        } set: { newValue in
            self[keyPath: keyPath] = newValue
        }
    }
    
}
