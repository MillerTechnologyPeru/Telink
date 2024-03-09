//
//  SerialPortEvent.swift
//  
//
//  Created by Alsey Coleman Miller on 3/8/24.
//

import Foundation

public protocol SerialPortProtocolEvent {
    
    static var type: SerialPortProtocolType { get }
}

public extension SerialPortProtocolEvent where Self: Decodable {
    
    init(from message: SerialPortProtocolMessage) throws {
        guard message.type == Self.type else {
            throw DecodingError.typeMismatch(Self.self, DecodingError.Context(codingPath: [], debugDescription: "Message is an incompatible type \(message.type). \(Self.self) expects type \(Self.type)"))
        }
        self = try SerialPortProtocolMessage.decoder.decode(Self.self, from: message.payload)
    }
}
