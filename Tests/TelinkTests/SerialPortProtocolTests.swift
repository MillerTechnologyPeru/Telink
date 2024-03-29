//
//  SerialPortProtocolTests.swift
//  
//
//  Created by Alsey Coleman Miller on 3/15/24.
//

import Foundation
import XCTest
@testable import Telink

final class SerialPortProtocolTests: XCTestCase {
    
    func testSerialPortProtocolMessageEncoding() throws {
        let encoder = SerialPortProtocolMessage.encoder
        let data = Data(hexadecimal: "55AA0009FFF6DD0B1518DB")!
        let command = SerialPortProtocolMessage(
            type: 0x55AA,
            payload: Data(hexadecimal: "FFF6DD0B1518DB")!
        )
        let encodedData = try encoder.encode(command)
        XCTAssertEqual(data, encodedData)
    }
    
    func testSerialPortProtocolMessageDecoding() throws {
        let decoder = SerialPortProtocolMessage.decoder
        let data = Data(hexadecimal: "55AA0008FFF7DD0B00D6")!
        let event = try decoder.decode(SerialPortProtocolMessage.self, from: data)
        XCTAssertEqual(event.type, 0x55AA)
        XCTAssertEqual(event.length, 8)
        XCTAssertEqual(event.payload, Data(hexadecimal: "FFF7DD0B00D6"))
    }
}
