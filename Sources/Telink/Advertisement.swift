//
//  Advertisement.swift
//
//
//  Created by Alsey Coleman Miller on 3/15/24.
//

import Foundation
import Bluetooth
import GATT

/// Telink Advertisement
public struct TelinkAdvertisement: Equatable, Hashable, Codable, Sendable {
    
    public let name: String
    
    public let manufacturerData: ManufacturerData
}

public extension TelinkAdvertisement {
    
    struct ManufacturerData: Equatable, Hashable, Codable, Sendable {
        
        public let vendor: Bluetooth.CompanyIdentifier
        
        public let address: TelinkAdvertisement.Address
    }
}

public extension TelinkAdvertisement {
    
    init?(name: String, manufacturerData: GATT.ManufacturerSpecificData) {
        guard let manufacturerDataValue = TelinkAdvertisement.ManufacturerData(manufacturerData: manufacturerData)
            else { return nil }
        self.name = name
        self.manufacturerData = manufacturerDataValue
    }
    
    init?<T: GATT.AdvertisementData>(_ advertisement: T) {
        guard let manufacturerData = advertisement.manufacturerData,
              let name = advertisement.localName
            else { return nil }
        self.init(name: name, manufacturerData: manufacturerData)
    }
}

public extension TelinkAdvertisement.ManufacturerData {
    
    static var companyIdentifier: CompanyIdentifier { .telinkSemiconductor }
    
    internal static var decoder: TelinkDecoder {
        TelinkDecoder(isLittleEndian: true)
    }
    
    init?(manufacturerData: GATT.ManufacturerSpecificData) {
        guard manufacturerData.companyIdentifier == Self.companyIdentifier else {
            return nil
        }
        guard let value = try? Self.decoder.decode(TelinkAdvertisement.ManufacturerData.self, from: manufacturerData.additionalData) else {
            return nil
        }
        self = value
    }
}
