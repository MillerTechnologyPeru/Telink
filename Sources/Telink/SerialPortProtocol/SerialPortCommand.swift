//
//  SerialPortCommand.swift
//  
//
//  Created by Alsey Coleman Miller on 3/8/24.
//

import Foundation

public protocol SerialPortProtocolCommand {
    
    static var type: SerialPortProtocolType { get }
}

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
