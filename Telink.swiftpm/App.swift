import Foundation
import SwiftUI
import CoreBluetooth
import Bluetooth
import GATT
import Telink

@main
struct TelinkApp: App {
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(AccessoryManager.shared)
        }
    }
}
