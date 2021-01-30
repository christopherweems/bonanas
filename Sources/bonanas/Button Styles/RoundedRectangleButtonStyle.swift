//
//  RoundedRectangleButtonStyle.swift
//  
//
//  Created by Christopher Weems on 1/29/21.
//

import SwiftUI
import unstandard

public struct RoundedRectangleButtonStyle: ButtonStyle {
    let fontSize: CGFloat
    
    let verticalPadding: CGFloat
    var horizontalPadding: CGFloat { verticalPadding * 2 }
    
    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.system(size: fontSize, weight: .semibold))
            .padding(.vertical, verticalPadding)
            .padding(.horizontal, horizontalPadding)
            .background(strokeRectangle)
            .contentShape(Rectangle())
            .opacity(configuration.isPressed ? 0.8 : 1.0)
        
    }
    
    public init(fontSize: CGFloat = 17) {
        self.fontSize = fontSize
        self.verticalPadding = (4 / 17) * fontSize
        
    }
    
}

fileprivate extension RoundedRectangleButtonStyle {
    var strokeLineWidth: CGFloat {
        (fontSize / 17) * .phi
    }
    
    var strokeRectangle: some View {
        RoundedRectangle(cornerRadius: 8)
            .stroke(style: StrokeStyle(lineWidth: strokeLineWidth))
    }
    
}
