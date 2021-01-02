//  TaggedView.swift
//  1/2/21

import SwiftUI

public struct TaggedView<Content, Tag>: View where Content: View, Tag : Hashable {
    fileprivate let content: Content
    fileprivate let tag: Tag
    
    public var body: some View {
        content
            .tag(tag)
    }
    
}


// MARK: - subscript property accessors

public extension TaggedView {
    struct Properties {
        public let tag: Tag
        
    }
    
    subscript<V>(property: KeyPath<Properties, V>) -> V {
        switch property {
        case \Properties.tag:
            return tag as! V
            
        default:
            fatalError()
        }
    }
    
}


// MARK: - View._tag(..)

public extension View {
    func _tag<Tag: Hashable>(_ tag: Tag) -> TaggedView<Self, Tag> {
        .init(content: self, tag: tag)
    }
    
}
