//  ControllerUserInteractionEnabled.swift
//  Created by Christopher Weems on 2/19/21

import Combine
import SwiftUI

public final class ControllerUserInteraction: ObservableObject {
    @Published public var isEnabled = true
    /* @Published public var allowsApplicationExit = true */
    
}

public extension EnvironmentValues {
    var controllerUserInteraction: ControllerUserInteraction {
        self[ControllerUserInteractionEnvironmentKey.self]
    }
    
}

fileprivate enum ControllerUserInteractionEnvironmentKey: EnvironmentKey {
    private static var _defaultValue = ControllerUserInteraction()
    
    static var defaultValue: ControllerUserInteraction {
        _defaultValue
    }
    
}
