//  ScenePhaseChangeCallbackViewModifier.swift
//  1/25/21

import SwiftUI

fileprivate struct ScenePhaseChangeCallbackViewModifier: ViewModifier {
    @Environment(\.scenePhase) var scenePhase
    
    let callbackScenePhase: ScenePhase
    let action: () -> Void
    
    func body(content: Content) -> some View {
        content
            .onChange(of: scenePhase == callbackScenePhase) {
                guard $0 else { return }
                action()
            }
    }
    
    init(scenePhase: ScenePhase, perform action: @escaping () -> Void) {
        self.callbackScenePhase = scenePhase
        self.action = action
        
    }
    
}

public extension View {
    func onScenePhaseChange(to value: ScenePhase, _ update: @escaping () -> Void) -> some View {
        self.modifier(ScenePhaseChangeCallbackViewModifier(scenePhase: value, perform: update))
            .onAppear {
                guard value == .active else { return }
                update()
            }
    }
    
}
