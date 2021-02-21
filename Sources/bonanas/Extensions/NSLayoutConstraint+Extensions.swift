//  NSLayoutConstraint+Extensions.swift
//  Created by Christopher Weems on 2/21/21

#if canImport(UIKit)
import UIKit
#elseif canImport(AppKit)
import AppKit
#endif

import unstandard

internal extension NSLayoutConstraint {
    #if canImport(UIKit)
    typealias ViewType = UIView
    #elseif canImport(AppKit)
    typealias ViewType = NSView
    #endif
    
}

#if canImport(UIKit) || canImport(AppKit)
internal extension NSLayoutConstraint {
    static func activate(views first: ViewType, _ second: ViewType,
                  @ProtocolTypedArrayBuilder<NSLayoutConstraint> constraints: (ViewType, ViewType) -> [NSLayoutConstraint]) {
        let constraints = constraints(first, second)
        Self.activate(constraints)
    }
    
}

internal extension NSLayoutConstraint.ViewType {
    func activateConstraints(@ProtocolTypedArrayBuilder<NSLayoutConstraint> _ constraints: (NSLayoutConstraint.ViewType) -> [NSLayoutConstraint]) {
        let constraints = constraints(self)
        
        self.addConstraints(constraints)
        NSLayoutConstraint.activate(constraints)
        
    }
    
}

#endif
