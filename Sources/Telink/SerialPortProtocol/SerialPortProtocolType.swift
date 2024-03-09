//
//  SerialPortProtocolType.swift
//
//
//  Created by Alsey Coleman Miller on 3/9/24.
//

/// Telink Serial Port Protocol Type
public struct SerialPortProtocolType: Equatable, Hashable, Codable, Sendable {
    
    public let rawValue: UInt16
    
    public init(rawValue: UInt16) {
        self.rawValue = rawValue
    }
}

// MARK: ExpressibleByIntegerLiteral

extension SerialPortProtocolType: ExpressibleByIntegerLiteral {
    
    public init(integerLiteral value: UInt16) {
        self.init(rawValue: value)
    }
}

// MARK: - CustomStringConvertible

extension SerialPortProtocolType: CustomStringConvertible {
    
    public var description: String {
        "0x" + rawValue.toHexadecimal()
    }
}
