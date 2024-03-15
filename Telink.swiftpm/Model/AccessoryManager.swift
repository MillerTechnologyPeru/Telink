//
//  Store.swift
//
//
//  Created by Alsey Coleman Miller on 3/15/24.
//

import Foundation
import SwiftUI
import CoreBluetooth
import Bluetooth
import GATT
import DarwinGATT
import Telink

@MainActor
public final class AccessoryManager: ObservableObject {
    
    // MARK: - Properties
    
    @Published
    public internal(set) var state: DarwinBluetoothState = .unknown
    
    public var isScanning: Bool {
        scanStream != nil
    }
    
    @Published
    public internal(set) var peripherals = [NativeCentral.Peripheral: TelinkAdvertisement]()
    
    @Published
    public internal(set) var scanResponses = [NativeCentral.Peripheral: TelinkScanResponse]()
    
    internal lazy var central = NativeCentral()
    
    @Published
    internal var scanStream: AsyncCentralScan<NativeCentral>?
    
    // MARK: - Initialization
    
    public static let shared = AccessoryManager()
    
    private init() {
        central.log = { [unowned self] in self.log("📲 Central: " + $0) }
        observeBluetoothState()
    }
}
