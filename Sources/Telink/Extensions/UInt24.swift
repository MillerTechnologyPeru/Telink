//
//  UInt24.swift
//
//
//  Created by Alsey Coleman Miller on 3/11/24.
//

import Foundation
import Bluetooth

extension UInt24: TelinkCodable {
    
    public init(from container: TelinkDecodingContainer) throws {
        let data = try container.decode(Data.self, length: UInt24.length)
        guard let value = UInt24(data: data) else {
            throw DecodingError.dataCorrupted(DecodingError.Context(codingPath: container.codingPath, debugDescription: "Invalid data."))
        }
        self = container.isLittleEndian ? value.littleEndian : value.bigEndian
    }
    
    public func encode(to container: TelinkEncodingContainer) throws {
        let value = container.isLittleEndian ? littleEndian : bigEndian
        try container.encode(value.data)
    }
}
