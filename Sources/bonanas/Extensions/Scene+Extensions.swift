//  Scene+Extensions.swift
//  Created by Christopher Weems on 2/24/21

import SwiftUI

public extension Scene {
    func modifier<Result>(_ modifications: (Self) -> Result) -> some Scene where Result : Scene {
        modifications(self)
    }
    
}
