//
//  SerialPortProtocol.swift
//
//
//  Created by Alsey Coleman Miller on 3/8/24.
//

import Foundation

public struct SerialPortProtocolMessage: Equatable, Hashable, Codable, Sendable {
    
    public let type: UInt16
    
    public let length: UInt16
    
    public let payload: Data
}

// MARK: - TelinkCodable

extension SerialPortProtocolMessage: TelinkCodable {
    
    public init(from container: TelinkDecodingContainer) throws {
        self.type = try container.decode(UInt16.self, isLittleEndian: false)
        self.length = try container.decode(UInt16.self, isLittleEndian: false)
        self.payload = try container.decode(Data.self, length: container.remainingBytes)
    }
    
    public func encode(to container: TelinkEncodingContainer) throws {
        try container.encode(type, isLittleEndian: false)
        try container.encode(length, isLittleEndian: false)
        try container.encode(payload, forKey: CodingKeys.payload)
    }
}
