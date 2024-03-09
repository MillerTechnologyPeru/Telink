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
        let address = try container.decode(length: 6) { BluetoothAddress(data: $0) }
        self = container.isLittleEndian ? address.littleEndian : address.bigEndian
    }
    
    public func encode(to container: TelinkEncodingContainer) throws {
        let data = container.isLittleEndian ? littleEndian.data : bigEndian.data
        try container.encode(data)
    }
}
