//  SystemImageResult.swift
//  Created by Christopher Weems on 3/23/21

import SwiftUI

@resultBuilder
public struct SystemImageResult {
    public static func buildBlock(_ image: Image) -> Image {
        image
    }
    
    public static func buildEither(first component: Image) -> Image {
        component
    }
    
    public static func buildEither(second component: Image) -> Image {
        component
    }
    
    public static func buildExpression(_ systemName: String) -> Image {
        Image(systemName: systemName)
    }
    
}
