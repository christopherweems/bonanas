//  View+Extensions.swift
//  12/30/20

import SwiftUI
import unstandard


// MARK: - Platform specific modifiers

public extension View {
    func modifier<Result>(platform platforms: Platform..., modifications: (Self) -> Result) -> AnyView where Result : View {
        guard platforms.union().contains(.current) else { return AnyView(erasing: self) }
        return AnyView(erasing: modifications(self))
    }
    
}

// MARK: - Size

public extension View {
    func frame(minSize: CGSize? = nil, idealSize: CGSize? = nil, maxSize: CGSize? = nil, alignment: Alignment = .center) -> some View {
        self.frame(minWidth: minSize?.width, idealWidth: idealSize?.width, maxWidth: maxSize?.width,
                   minHeight: minSize?.height, idealHeight: idealSize?.height, maxHeight: maxSize?.height,
                   alignment: alignment)
    }
    
}


// MARK: - On Appear Async

public extension View {
    func onAppearAsync(perform action: (() -> Void)? = nil) -> some View {
        self.onAppear {
            guard let action = action else { return }
            DispatchQueue.main.async(execute: action)
        }
    }
    
}


// MARK: - View Builder Overlay

public extension View {
    func overlay<Overlay>(@ViewBuilder _ overlay: () -> Overlay) -> some View where Overlay: View {
        self.overlay(overlay())
    }
    
}


// MARK: - Alert

public extension View {
    /// Presents an \`AlertProtocol\` Alert to the user.
    ///
    /// - Parameters:
    ///   - isPresented: A binding to whether the alert should be shown.
    ///   - content: An `_Alert` structure
    func alert(isPresented: Binding<Bool>, content: () -> AlertProtocol) -> some View {
        self.alert(isPresented: isPresented, content: { content().body })
    }
    
}

