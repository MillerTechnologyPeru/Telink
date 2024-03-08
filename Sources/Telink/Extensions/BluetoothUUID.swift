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
        return BluetoothUUID(rawValue: "00010203-0405-0607-0809-0A0B0C0D1910")!
    }
    
    static var telinkSerialPortProtocolNotification: BluetoothUUID {
        BluetoothUUID(rawValue: "00010203-0405-0607-0809-0A0B0C0D2B10")!
    }
    
    static var telinkSerialPortProtocolCommand: BluetoothUUID {
        BluetoothUUID(rawValue: "00010203-0405-0607-0809-0A0B0C0D2B11")!
    }
    
    static var meshLightAccessService: BluetoothUUID {
        return BluetoothUUID(rawValue: "00010203-0405-0607-0809-0A0B0C0D1910")!
    }
    
    static var meshLightStatusCharacteristic: BluetoothUUID {
        return BluetoothUUID(rawValue: "00010203-0405-0607-0809-0A0B0C0D1911")!
    }
    
    static var meshLightCommandCharacteristic: BluetoothUUID {
        return BluetoothUUID(rawValue: "00010203-0405-0607-0809-0A0B0C0D1912")!
    }
    
    static var meshLightFirmwareUpdateCharacteristic: BluetoothUUID {
        return BluetoothUUID(rawValue: "00010203-0405-0607-0809-0A0B0C0D1913")!
    }
    
    static var meshLightPairingCharacteristic: BluetoothUUID {
        return BluetoothUUID(rawValue: "00010203-0405-0607-0809-0A0B0C0D1914")!
    }
}
