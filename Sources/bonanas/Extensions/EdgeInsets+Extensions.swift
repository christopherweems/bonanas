//
//  EdgeInsets+Extensions.swift
//  
//
//  Created by Christopher Weems on 3/19/21.
//

import SwiftUI
import unstandard

public extension EdgeInsets {
    static var zero: EdgeInsets { .init(top: 0, leading: 0, bottom: 0, trailing: 0) }
    
    @AnyTrue var isNonZero: Bool {
        top != 0
        leading != 0
        trailing != 0
        bottom != 0
        
    }
    
}
