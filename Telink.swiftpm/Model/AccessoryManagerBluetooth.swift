//
//  AccessoryManagerBluetooth.swift
//  
//
//  Created by Alsey Coleman Miller on 3/6/24.
//

import Foundation
import Bluetooth
import GATT
import DarwinGATT
import Telink

public extension AccessoryManager {
    
    /// The Bluetooth LE peripheral for the speciifed device identifier..
    subscript (peripheral address: TelinkAdvertisement.Address) -> NativeCentral.Peripheral? {
        return peripherals.first(where: { $0.value.manufacturerData.address == address })?.key
    }
    
    func scan(
        duration: TimeInterval? = nil
    ) async throws {
        let bluetoothState = await central.state
        guard bluetoothState == .poweredOn else {
            throw TelinkAppError.bluetoothUnavailable
        }
        let filterDuplicates = true //preferences.filterDuplicates
        self.peripherals.removeAll(keepingCapacity: true)
        stopScanning()
        let scanStream = central.scan(
            with: [],
            filterDuplicates: filterDuplicates
        )
        self.scanStream = scanStream
        let task = Task { [unowned self] in
            for try await scanData in scanStream {
                guard found(scanData) else { continue }
            }
        }
        if let duration = duration {
            precondition(duration > 0.001)
            try await Task.sleep(timeInterval: duration)
            scanStream.stop()
            try await task.value // throw errors
        } else {
            // error not thrown
            Task { [unowned self] in
                do { try await task.value }
                catch is CancellationError { }
                catch {
                    self.log("Error scanning: \(error)")
                }
            }
        }
    }
    
    func stopScanning() {
        scanStream?.stop()
        scanStream = nil
    }
}

internal extension AccessoryManager {
    
    func observeBluetoothState() {
        // observe state
        Task { [weak self] in
            while let self = self {
                let newState = await self.central.state
                let oldValue = self.state
                if newState != oldValue {
                    self.state = newState
                }
                try await Task.sleep(timeInterval: 0.5)
            }
        }
    }
    
    var loadConnections: Set<NativePeripheral> {
        get async {
            let peripherals = await self.central
                .peripherals
                .filter { $0.value }
                .map { $0.key }
            return Set(peripherals)
        }
    }
    
    func found(_ scanData: ScanData<NativeCentral.Peripheral, NativeCentral.Advertisement>) -> Bool {
        if let manufacturerData = scanData.advertisementData.manufacturerData,
                  let scanResponse = TelinkScanResponse(manufacturerData: manufacturerData) {
            self.scanResponses[scanData.peripheral] = scanResponse
            return true
        } else if let advertisement = TelinkAdvertisement(scanData.advertisementData) {
            self.peripherals[scanData.peripheral] = advertisement
            return true
        } else {
            return false
        }
    }
}
