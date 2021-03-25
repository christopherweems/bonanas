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
    
    func frame(size: CGSize, alignment: Alignment = .center) -> some View {
        self.frame(width: size.width, height: size.height, alignment: alignment)
    }
    
}


// MARK: - Padding

public extension View {
    func padding(_ edges: Edge.Set, matching insets: EdgeInsets) -> some View {
        self
            .padding(.leading, edges.contains(.leading) ? insets.leading : 0)
            .padding(.trailing, edges.contains(.trailing) ? insets.trailing : 0)
            .padding(.top, edges.contains(.top) ? insets.top : 0)
            .padding(.bottom, edges.contains(.bottom) ? insets.bottom : 0)
        
    }
    
}


// MARK: - Transition

public extension View {
    func transition(_ transition: () -> AnyTransition) -> some View {
        self.transition(transition())
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
    func overlay<Overlay>(alignment: Alignment = .center, @ViewBuilder _ overlay: () -> Overlay) -> some View where Overlay: View {
        self.overlay(overlay(), alignment: alignment)
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


// MARK: - `.navigationBarItems(leading:trailing:revreseOrder:)`

public extension View {
    #if os(iOS) || os(tvOS)
    @available(iOS, introduced: 13.0, deprecated: 100000.0, message: "Use toolbar(_:) with navigationBarLeading or navigationBarTrailing placement")
    @available(tvOS, introduced: 13.0, deprecated: 100000.0, message: "Use toolbar(_:) with navigationBarLeading or navigationBarTrailing placement")
    @available(macOS, unavailable)
    @available(watchOS, unavailable)
    @ViewBuilder func navigationBarItems<L, T>(leading: L, trailing: T, reverseOrder: Bool) -> some View where L : View, T : View {
        if reverseOrder {
            self.navigationBarItems(leading: trailing, trailing: leading)
            
        } else {
            self.navigationBarItems(leading: leading, trailing: trailing)
            
        }
    }
    #endif
    
}


// MARK: - Assign value on change

public extension View {
    func onChange<Root, Value>(of value: Value, assignTo keyPath: ReferenceWritableKeyPath<Root, Value>, on root: Root) -> some View where Value : Equatable {
        func assign(value: Value) { root[keyPath: keyPath] = value }
        
        return self
            .onAppear { assign(value: value) }
            .onChange(of: value, perform: assign(value:))
    }
    
}


// MARK: - `View.onAppearAndChange(of:perform:)`

public extension View {
    func onAppearAndChange<Value>(of value: Value, perform action: @escaping (Value) -> Void) -> some View where Value : Equatable {
        self.onAppear(perform: { action(value) })
            .onChange(of: value, perform: action)
    }
    
}

