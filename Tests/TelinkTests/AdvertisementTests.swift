//
//  AdvertisementTests.swift
//
//
//  Created by Alsey Coleman Miller on 3/15/24.
//

import Foundation
import XCTest
import Bluetooth
import GATT
@testable import Telink

final class AdvertisementTests: XCTestCase {
    
    func testMotionSensorAdvertisement() throws {
        
        /*
         HCI Event        0x0000  34:13:43:21:73:78  LE - Ext ADV - 1 Report - Normal - Public - 34:13:43:21:73:78  -43 dBm - 3ABE261FDA22 - Manufacturer Specific Data - Channel 38
             Parameter Length: 53 (0x35)
             Num Reports: 0X01
             Report 0
                 Event Type: Connectable Advertising - Scannable Advertising - Legacy Advertising PDUs Used - Complete -
                 Address Type: Public
                 Peer Address: 34:13:43:21:73:78
                 Primary PHY: 1M
                 Secondary PHY: No Packets
                 Advertising SID: Unavailable
                 Tx Power: Unavailable
                 RSSI: -43 dBm
                 Periodic Advertising Interval: 0.000000ms (0x0)
                 Direct Address Type: Public
                 Direct Address: 00:00:00:00:00:00
                 Data Length: 27
                 Flags: 0x5
                     LE Limited Discoverable Mode
                     BR/EDR Not Supported
                 Local Name: 3ABE261FDA22
                 Data: 02 01 05 0D 09 33 41 42 45 32 36 31 46 44 41 32 32 09 FF 11 02 11 02 78 73 21 43
         */
        
        let advertisementData: LowEnergyAdvertisingData = [0x02, 0x01, 0x05, 0x0D, 0x09, 0x33, 0x41, 0x42, 0x45, 0x32, 0x36, 0x31, 0x46, 0x44, 0x41, 0x32, 0x32, 0x09, 0xFF, 0x11, 0x02, 0x11, 0x02, 0x78, 0x73, 0x21, 0x43]
        
        XCTAssertEqual(advertisementData.localName, "3ABE261FDA22")
        XCTAssertEqual(advertisementData.manufacturerData?.companyIdentifier, .telinkSemiconductor)
        XCTAssertEqual(advertisementData.manufacturerData?.additionalData.count, 6)
        
        guard let advertisement = TelinkAdvertisement(advertisementData) else {
            XCTFail()
            return
        }
        
        XCTAssertEqual(advertisement.name, "3ABE261FDA22")
        XCTAssertEqual(advertisement.manufacturerData.vendor, .telinkSemiconductor)
        XCTAssertEqual(advertisement.manufacturerData.address.rawValue, "43:21:73:78")
    }
    
    func testMotionSensorScanResponse() throws {
        
        /*
         HCI Event        0x0000  34:13:43:21:73:78  LE - Ext ADV - 1 Report - Normal - Public - 34:13:43:21:73:78  -43 dBm - Manufacturer Specific Data - Channel 38
             Parameter Length: 57 (0x39)
             Num Reports: 0X01
             Report 0
                 Event Type: Connectable Advertising - Scannable Advertising - Scan Response - Legacy Advertising PDUs Used - Complete -
                 Address Type: Public
                 Peer Address: 34:13:43:21:73:78
                 Primary PHY: 1M
                 Secondary PHY: No Packets
                 Advertising SID: Unavailable
                 Tx Power: Unavailable
                 RSSI: -43 dBm
                 Periodic Advertising Interval: 0.000000ms (0x0)
                 Direct Address Type: Public
                 Direct Address: 00:00:00:00:00:00
                 Data Length: 31
                 Data: 1E FF 11 02 11 02 78 73 21 43 60 00 01 4B 00 00 01 02 03 04 05 06 07 08 09 0A 0B 0C 0D 0E 0F
         */
        
        let scanResponseData: LowEnergyAdvertisingData = [0x1E, 0xFF, 0x11, 0x02, 0x11, 0x02, 0x78, 0x73, 0x21, 0x43, 0x60, 0x00, 0x01, 0x4B, 0x00, 0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08, 0x09, 0x0A, 0x0B, 0x0C, 0x0D, 0x0E, 0x0F]
        
        XCTAssertNil(scanResponseData.localName)
        XCTAssertEqual(scanResponseData.manufacturerData?.companyIdentifier, .telinkSemiconductor)
        XCTAssertEqual(scanResponseData.manufacturerData?.additionalData.count, 27)
        
        guard let manufacturerData = scanResponseData.manufacturerData,
              let advertisement = TelinkScanResponse(manufacturerData: manufacturerData) else {
            XCTFail()
            return
        }
        
        XCTAssertEqual(advertisement.vendor, .telinkSemiconductor)
        XCTAssertEqual(advertisement.address.rawValue, "43:21:73:78")
        XCTAssertEqual(advertisement.productType, 96)
        XCTAssertEqual(advertisement.status, 1)
        XCTAssertEqual(advertisement.mesh, 75)
        XCTAssertEqual(advertisement.additionalData, Data([0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15]))
        XCTAssertEqual(advertisement.additionalData.count, 16)
    }
}
