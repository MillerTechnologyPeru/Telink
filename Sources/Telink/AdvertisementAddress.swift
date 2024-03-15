//
//  TelinkAdvertisement.Address.swift
//
//
//  Created by Alsey Coleman Miller on 3/15/24.
//

import Foundation
import Bluetooth

public extension TelinkAdvertisement {
    
    struct Address: Sendable {
        
        public typealias ByteValue = (UInt8, UInt8, UInt8, UInt8)
            
        public var bytes: ByteValue
            
        public init(bytes: ByteValue) {
            self.bytes = bytes
        }
    }
}

public extension TelinkAdvertisement.Address {
    
    init(address: BluetoothAddress) {
        let bytes = address.bigEndian.bytes
        self.init(bigEndian: TelinkAdvertisement.Address(bytes: (bytes.2, bytes.3, bytes.4, bytes.5)))
    }
}

// MARK: - Definitions

public extension TelinkAdvertisement.Address {
    
    static var min: TelinkAdvertisement.Address { return .init(bytes: (.min, .min, .min, .min)) }
    
    static var max: TelinkAdvertisement.Address { return .init(bytes: (.max, .max, .max, .max)) }
    
    static var zero: TelinkAdvertisement.Address { return .min }
}

// MARK: - Data

public extension TelinkAdvertisement.Address {
    
    internal static var length: Int { return MemoryLayout<ByteValue>.size }
    
    init?(data: Data) {
        guard data.count == type(of: self).length
            else { return nil }
        self.init(bytes: (data[0], data[1], data[2], data[3]))
    }
    
    var data: Data {
        return Data([bytes.0, bytes.1, bytes.2, bytes.3])
    }
}

// MARK: - RawRepresentable

extension TelinkAdvertisement.Address: RawRepresentable {
    
    public init?(rawValue: String) {
        
        guard rawValue.utf8.count == 11
            else { return nil }
        
        var bytes: ByteValue = (0, 0, 0, 0)
        let components = rawValue.components(separatedBy: ":")
        guard components.count == Self.length
            else { return nil }
        
        for (index, string) in components.enumerated() {
            guard let byte = UInt8(string, radix: 16)
                else { return nil }
            withUnsafeMutablePointer(to: &bytes) {
                $0.withMemoryRebound(to: UInt8.self, capacity: Self.length) {
                    $0.advanced(by: index).pointee = byte
                }
            }
        }
        
        self.init(bigEndian: Self.init(bytes: bytes))
        
        // validate
        guard self.rawValue.uppercased() == rawValue.uppercased()
            else { return nil }
    }
    
    public var rawValue: String {
        return reduce("", { $0 + ($0.isEmpty ? "" : ":") + $1.toHexadecimal() })
    }
}

// MARK: - Codable

extension TelinkAdvertisement.Address: Codable { }

// MARK: - Equatable

extension TelinkAdvertisement.Address: Equatable {
    
    public static func == (lhs: TelinkAdvertisement.Address, rhs: TelinkAdvertisement.Address) -> Bool {
        return lhs.bytes.0 == rhs.bytes.0
            && lhs.bytes.1 == rhs.bytes.1
            && lhs.bytes.2 == rhs.bytes.2
            && lhs.bytes.3 == rhs.bytes.3
    }
}

// MARK: - Hashable

extension TelinkAdvertisement.Address: Hashable {
    
    public func hash(into hasher: inout Hasher) {
        withUnsafeBytes(of: bytes, { hasher.combine(bytes: $0) })
    }
}

// MARK: - CustomStringConvertible

extension TelinkAdvertisement.Address: CustomStringConvertible {
    
    public var description: String { return rawValue }
}

// MARK: - Byte Swap

extension TelinkAdvertisement.Address: ByteSwap {
    
    public var byteSwapped: TelinkAdvertisement.Address {
        return TelinkAdvertisement.Address(bytes: (bytes.3, bytes.2, bytes.1, bytes.0))
    }
}

// MARK: Sequence

extension TelinkAdvertisement.Address: Sequence {
    
    public func makeIterator() -> IndexingIterator<Self> {
        return IndexingIterator(_elements: self)
    }
}

// MARK: RandomAccessCollection

extension TelinkAdvertisement.Address: RandomAccessCollection {
    
    public var count: Int {
        return type(of: self).length
    }
    
    public subscript (index: Int) -> UInt8 {
        let bytes = self.bigEndian.bytes
        switch index {
        case 0: return bytes.0
        case 1: return bytes.1
        case 2: return bytes.2
        case 3: return bytes.3
        default: fatalError("Invalid index \(index)")
        }
    }
    
    /// The start `Index`.
    public var startIndex: Int {
        return 0
    }
    
    /// The end `Index`.
    ///
    /// This is the "one-past-the-end" position, and will always be equal to the `count`.
    public var endIndex: Int {
        return count
    }
    
    public func index(before i: Int) -> Int {
        return i - 1
    }
    
    public func index(after i: Int) -> Int {
        return i + 1
    }
}
