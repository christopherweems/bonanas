//  UnstyledButtonStyle.swift
//  Created by Christopher Weems on 3/22/21

import SwiftUI

public struct UnstyledButtonStyle: ButtonStyle {
    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
    }
    
    public init() { }
    
}
