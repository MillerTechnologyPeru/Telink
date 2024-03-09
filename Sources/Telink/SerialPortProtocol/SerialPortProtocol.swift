//
//  SerialPortProtocol.swift
//
//
//  Created by Alsey Coleman Miller on 3/8/24.
//

import Foundation

public struct SerialPortProtocolMessage: Equatable, Hashable, Codable, Sendable {
    
    public let type: SerialPortProtocolType
    
    public let length: UInt16
    
    public let payload: Data
}

public extension SerialPortProtocolMessage {
    
    init(from data: Data) throws {
        self = try Self.decoder.decode(SerialPortProtocolMessage.self, from: data)
    }
    
    func encode() throws -> Data {
        try Self.encoder.encode(self)
    }
}

internal extension SerialPortProtocolMessage {
    
    static let encoder = TelinkEncoder()
    
    static let decoder = TelinkDecoder()
}

// MARK: - TelinkCodable

extension SerialPortProtocolMessage: TelinkCodable {
    
    public init(from container: TelinkDecodingContainer) throws {
        self.type = SerialPortProtocolType(rawValue: try container.decode(UInt16.self, isLittleEndian: false))
        self.length = try container.decode(UInt16.self, isLittleEndian: false)
        self.payload = try container.decode(Data.self, length: container.remainingBytes)
    }
    
    public func encode(to container: TelinkEncodingContainer) throws {
        try container.encode(type.rawValue, isLittleEndian: false)
        try container.encode(length, isLittleEndian: false)
        try container.encode(payload, forKey: CodingKeys.payload)
    }
}
