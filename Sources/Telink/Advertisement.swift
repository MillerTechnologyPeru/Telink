//
//  Advertisement.swift
//
//
//  Created by Alsey Coleman Miller on 3/15/24.
//

import Foundation
import Bluetooth

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
