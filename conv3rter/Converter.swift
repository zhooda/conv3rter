//
//  Converter.swift
//  conv3rter
//
//  Created by Zeeshan Hooda on 4/10/20.
//  Copyright © 2020 Deceptive Labs. All rights reserved.
//

import Foundation

class Converter {
    
    internal func decimalToBinary(dec: UInt64) -> String {
        return String(dec, radix: 2)
    }
    
    internal func decimalToHex(dec: UInt64) -> String {
        return String(dec, radix: 16).uppercased()
    }
    
    internal func binaryToDecimal(bin: String) -> String {
        return String(Int(bin, radix: 2)!)
    }
    
    internal func binaryToHex(bin: String) -> String {
        return  String(Int(bin, radix: 2)!, radix: 16).uppercased()
    }
    
    internal func hexToDecimal(hex: String) -> String {
        return String(Int(hex, radix: 16)!)
    }
    
    internal func hexToBinary(hex: String) -> String {
        return String(Int(hex, radix: 16)!, radix: 2)
    }

}
