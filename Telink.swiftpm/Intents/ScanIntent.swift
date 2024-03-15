//
//  ScanIntent.swift
//  TelinkApp
//
//  Created by Alsey Coleman Miller on 3/15/24.
//

import Foundation
import AppIntents
import SwiftUI
import Telink

@available(iOS 16, *)
struct ScanIntent: AppIntent {
        
    static var title: LocalizedStringResource { "Scan for Xiaomi Bluetooth devices" }
    
    static var description: IntentDescription {
        IntentDescription(
            "Scan for nearby devices",
            categoryName: "Utility",
            searchKeywords: ["scan", "bluetooth", "Xiaomi", "thermometer"]
        )
    }
    
    static var parameterSummary: some ParameterSummary {
        Summary("Scan nearby devices for \(\.$duration) seconds")
    }
    
    @Parameter(
        title: "Duration",
        description: "Duration in seconds for scanning.",
        default: 1.5
    )
    var duration: TimeInterval
    
    @MainActor
    func perform() async throws -> some IntentResult {
        let store = AccessoryManager.shared
        try await store.central.wait(for: .poweredOn, warning: 2, timeout: 5)
        try await store.scan(duration: duration)
        let advertisements = store.peripherals
            .values
            .sorted(by: { $0.manufacturerData.address.rawValue < $1.manufacturerData.address.rawValue })
        let results = advertisements.map { $0.manufacturerData.address.rawValue }
        return .result(
            value: results,
            view: view(for: advertisements)
        )
    }
}

@available(iOS 16, *)
@MainActor
private extension ScanIntent {
    
    func view(for results: [TelinkAdvertisement]) -> some View {
        HStack(alignment: .top, spacing: 0) {
            VStack(alignment: .leading, spacing: 8) {
                if results.isEmpty {
                    Text("No devices found.")
                        .padding(20)
                } else {
                    if results.count > 3 {
                        Text("Found \(results.count) devices.")
                            .padding(20)
                    } else {
                        ForEach(results) {
                            view(for: $0)
                                .padding(8)
                        }
                    }
                }
            }
            Spacer(minLength: 0)
        }
    }
    
    func view(for advertisement: TelinkAdvertisement) -> some View {
        TelinkAdvertisementRow(
            advertisement: advertisement
        )
    }
}
