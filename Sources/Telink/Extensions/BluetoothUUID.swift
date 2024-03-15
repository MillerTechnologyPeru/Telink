//
//  BluetoothUUID.swift
//  
//
//  Created by Alsey Coleman Miller on 3/8/24.
//

import Foundation
import Bluetooth

public extension BluetoothUUID {
    
    static var telinkSerialPortProtocolService: BluetoothUUID {
        BluetoothUUID(rawValue: "00010203-0405-0607-0809-0A0B0C0D1910")!
    }
    
    static var telinkSerialPortProtocolNotification: BluetoothUUID {
        BluetoothUUID(rawValue: "00010203-0405-0607-0809-0A0B0C0D2B10")!
    }
    
    static var telinkSerialPortProtocolCommand: BluetoothUUID {
        BluetoothUUID(rawValue: "00010203-0405-0607-0809-0A0B0C0D2B11")!
    }
    
    static var telinkMeshService: BluetoothUUID {
        BluetoothUUID(rawValue: "00010203-0405-0607-0809-0A0B0C0D1910")!
    }
    
    static var telinkStatusCharacteristic: BluetoothUUID {
        BluetoothUUID(rawValue: "00010203-0405-0607-0809-0A0B0C0D1911")!
    }
    
    static var telinkCommandCharacteristic: BluetoothUUID {
        BluetoothUUID(rawValue: "00010203-0405-0607-0809-0A0B0C0D1912")!
    }
    
    static var telinkFirmwareUpdateCharacteristic: BluetoothUUID {
        BluetoothUUID(rawValue: "00010203-0405-0607-0809-0A0B0C0D1913")!
    }
    
    static var telinkPairingCharacteristic: BluetoothUUID {
        BluetoothUUID(rawValue: "00010203-0405-0607-0809-0A0B0C0D1914")!
    }
}
