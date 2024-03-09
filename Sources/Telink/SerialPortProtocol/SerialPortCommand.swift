//
//  SerialPortCommand.swift
//  
//
//  Created by Alsey Coleman Miller on 3/8/24.
//

import Foundation
import Bluetooth
import GATT

public protocol SerialPortProtocolCommand {
    
    static var type: SerialPortProtocolType { get }
}

// MARK: - Encoding

public extension SerialPortProtocolMessage {
    
    init<T>(
        command: T
    ) throws where T: SerialPortProtocolCommand, T: Encodable {
        let type = T.type
        let payload = try Self.encoder.encode(command)
        self.init(
            type: type,
            length: UInt16(payload.count),
            payload: payload
        )
    }
}

// MARK: - Central

public extension CentralManager {
    
    /// Send a Telink SPP command.
    func sendSerialPortProtocol<Command>(
        command: Command,
        characteristic: Characteristic<Self.Peripheral, Self.AttributeID>
    ) async throws where Command: SerialPortProtocolCommand, Command: Encodable {
        assert(characteristic.uuid == .telinkSerialPortProtocolCommand)
        let message = try SerialPortProtocolMessage(command: command)
        let data = try message.encode()
        try await self.writeValue(data, for: characteristic, withResponse: false)
    }
}
