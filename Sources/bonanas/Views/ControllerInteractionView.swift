//  ControllerInteractionView.swift
//  Created by Christopher Weems on 2/19/21

import Combine
import GameController
import SwiftUI
import unstandard

public struct ControllerInteractionView<Content>: View where Content : View {
    public let content: () -> Content
    
    public var body: some View {
        #if os(tvOS)
        VCContent(content: content)
            .edgesIgnoringSafeArea(.all)
        
        #else
        content()
        
        #endif
    }
    
    public init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content
        
    }
    
}


// MARK: -

#if os(tvOS)
fileprivate struct VCContent<Content>: UIViewControllerRepresentable where Content : View {
    let content: () -> Content
    
    func makeUIViewController(context: Context) -> ContentViewController<Content> {
        .init(content: content, controllerUserInteraction: context.environment.controllerUserInteraction)
    }
    
    func updateUIViewController(_ viewController: ContentViewController<Content>, context: Context) { }
    
}

fileprivate class ContentViewController<Content>: GCEventViewController where Content : View {
    private var controllerUserInteractionEnabledSink: AnyCancellable!
    private var lastPressEndedDate = Date.distantPast
    
    let content: () -> Content
    
    override func loadView() {
        self.view = UIView()
        
        let contentViewController = UIHostingController(rootView: content())
        contentViewController.view.translatesAutoresizingMaskIntoConstraints = false
        
        self.addChild(contentViewController)
        self.view.addSubview(contentViewController.view)
        
        NSLayoutConstraint.activate(views: view, contentViewController.view) {
            $0.leftAnchor.constraint(equalTo: $1.leftAnchor)
            $0.rightAnchor.constraint(equalTo: $1.rightAnchor)
            $0.topAnchor.constraint(equalTo: $1.topAnchor)
            $0.bottomAnchor.constraint(equalTo: $1.bottomAnchor)
            
        }
        
    }
    
    init(content: @escaping () -> Content, controllerUserInteraction: ControllerUserInteraction) {
        self.content = content
        super.init(nibName: nil, bundle: nil)
        
        self.controllerUserInteractionEnabledSink = controllerUserInteraction.$isEnabled.sink { [weak self] isEnabled in
            guard isEnabled != self?.controllerUserInteractionEnabled else { return }
            
            if isEnabled {
                DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(120)) {
                    self?.controllerUserInteractionEnabled = isEnabled
                    
                }
                
            } else {
                self?.controllerUserInteractionEnabled = isEnabled
                
            }
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
}

#endif
