//
//  SerialPortCommand.swift
//  
//
//  Created by Alsey Coleman Miller on 3/8/24.
//

import Foundation

public protocol SerialPortProtocolCommand {
    
    static var type: SerialPortProtocolType { get }
}
