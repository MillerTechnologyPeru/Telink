//
//  BluetoothAddress.swift
//
//
//  Created by Alsey Coleman Miller on 3/9/24.
//

import Foundation
import Bluetooth

// MARK: - BluetoothAddress

extension BluetoothAddress: TelinkCodable {
    
    public init(from container: TelinkDecodingContainer) throws {
        self = try container.decode(length: 6) { BluetoothAddress(data: $0)?.littleEndian }
    }
    
    public func encode(to container: TelinkEncodingContainer) throws {
        try container.encode(littleEndian.data)
    }
}
