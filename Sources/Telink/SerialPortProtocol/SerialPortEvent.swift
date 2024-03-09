//
//  SerialPortEvent.swift
//  
//
//  Created by Alsey Coleman Miller on 3/8/24.
//

import Foundation
import Bluetooth
import GATT

public protocol SerialPortProtocolEvent {
    
    static var type: SerialPortProtocolType { get }
}

// MARK: - Decoding

public extension SerialPortProtocolEvent where Self: Decodable {
    
    init(from message: SerialPortProtocolMessage) throws {
        guard message.type == Self.type else {
            throw DecodingError.typeMismatch(Self.self, DecodingError.Context(
                codingPath: [],
                debugDescription: "Message is an incompatible type \(message.type). \(Self.self) expects type \(Self.type)")
            )
        }
        self = try SerialPortProtocolMessage.decoder.decode(Self.self, from: message.payload)
    }
}

// MARK: - Central

public extension CentralManager {
    
    /// Receive Telink SPP events.
    func recieveSerialPortProtocol<Event>(
        _ event: Event.Type,
        characteristic: Characteristic<Peripheral, AttributeID>
    ) async throws -> AsyncIndefiniteStream<Event> where Event: SerialPortProtocolEvent, Event: Decodable {
        assert(characteristic.uuid == .telinkSerialPortProtocolNotification)
        let notifications = try await self.notify(for: characteristic)
        return AsyncIndefiniteStream<Event> { build in
            for try await data in notifications {
                let message = try SerialPortProtocolMessage(from: data)
                let event = try Event.init(from: message)
                build(event)
            }
        }
    }
}
