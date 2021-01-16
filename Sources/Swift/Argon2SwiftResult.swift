//
//  Argon2SwiftResult.swift
//  Argon2Swift
//
//  Created by Tejas Mehta on 1/15/21.
//

import Foundation

public class Argon2SwiftResult {
    
    let hashBytes: [Int8]
    let encodedBytes: [Int8]
    
    public init(hashBytes: [Int8], encodedBytes: [Int8]) {
        self.hashBytes = hashBytes
        self.encodedBytes = encodedBytes
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
