//
//  SerialPortEvent.swift
//  
//
//  Created by Alsey Coleman Miller on 3/8/24.
//

import Foundation

public protocol SerialPortProtocolEvent {
    
    static var type: SerialPortProtocolType { get }
}
