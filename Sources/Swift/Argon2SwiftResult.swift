//
//  Argon2SwiftResult.swift
//  Argon2Swift
//
//  Created by Tejas Mehta on 1/15/21.
//

import Foundation

public class Argon2SwiftResult {
    
    // Both hashed calues
    let hashBytes: [UInt8]
    let encodedBytes: [UInt8]
    
    public init(hashBytes: [Int8], encodedBytes: [Int8]) {
        // Convert to UInt8 arrays and set
        self.hashBytes = hashBytes.map { UInt8(bitPattern: $0) }
        self.encodedBytes = encodedBytes.map{ UInt8(bitPattern: $0) }
    }
    
    public func hashData() -> Data {
        return Data(hashBytes);
    }
    
    public func encodedData() -> Data {
        return Data(encodedBytes);
    }
    
    public func base64String() -> String {
        return Data(hashBytes).base64EncodedString()
    }
    
    public func hexString() -> String {
        return hashBytes.map{ String(format: "%02hhx", $0) }.joined()
    }
    
    public func encodedString() -> String? {
        return String(data: Data(encodedBytes), encoding: .utf8)
    }
}
