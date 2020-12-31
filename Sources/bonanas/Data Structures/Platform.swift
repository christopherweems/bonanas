//  Platform.swift
//  12/30/20

public struct Platform: OptionSet {
    public static let current: Self = {
        #if os(macOS)
        return .mac
        #elseif os(iOS)
        return .iOS
        #else
        fatalError()
        #endif
    }()
    
    public let rawValue: Int
    
    public static let mac = Platform(rawValue: 1 << 0)
    public static let iOS = Platform(rawValue: 1 << 1)
    
    public init(rawValue: Int) {
        self.rawValue = rawValue
        
    }
    
}
