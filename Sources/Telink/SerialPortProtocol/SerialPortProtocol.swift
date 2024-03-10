//
//  SerialPortProtocol.swift
//
//
//  Created by Alsey Coleman Miller on 3/8/24.
//

import Foundation

/// Telink SPP message
public struct SerialPortProtocolMessage: Equatable, Hashable, Codable, Sendable {
    
    public let type: SerialPortProtocolType
    
    internal let length: UInt16
    
    public let payload: Data
    
    public init(type: SerialPortProtocolType, payload: Data) {
        self.type = type
        self.payload = payload
        self.length = UInt16(payload.count) + 2
    }
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
    
    static let encoder = TelinkEncoder(isLittleEndian: false)
    
    static let decoder = TelinkDecoder(isLittleEndian: false)
}
