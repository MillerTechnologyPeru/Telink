//
//  Codable.swift
//  
//
//  Created by Alsey Coleman Miller on 3/9/24.
//

import Foundation

// MARK: - TelinkCodable

/// Telink Codable
public typealias TelinkCodable = TelinkEncodable & TelinkDecodable

/// Telink Decodable type
public protocol TelinkDecodable: Decodable {
    
    init(from container: TelinkDecodingContainer) throws
}

/// Telink Encodable type
public protocol TelinkEncodable: Encodable {
    
    func encode(to container: TelinkEncodingContainer) throws
}
