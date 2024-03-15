//
//  ScanResponse.swift
//
//
//  Created by Alsey Coleman Miller on 3/15/24.
//

import Foundation
import Bluetooth
import GATT

public struct TelinkScanResponse: Equatable, Hashable, Codable, Sendable {
    
    public let vendor: Bluetooth.CompanyIdentifier
    
    public let address: TelinkAdvertisement.Address
    
    public let productType: UInt16
    
    public let status: UInt8
    
    public let mesh: UInt16
}

public extension TelinkScanResponse {
    
    init?(manufacturerData: GATT.ManufacturerSpecificData) {
        guard manufacturerData.companyIdentifier == TelinkAdvertisement.ManufacturerData.companyIdentifier else {
            return nil
        }
        guard let value = try? TelinkAdvertisement.ManufacturerData.decoder.decode(TelinkScanResponse.self, from: manufacturerData.additionalData) else {
            return nil
        }
        self = value
    }
}
