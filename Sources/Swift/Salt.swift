//
//  Salt.swift
//  Argon2Swift
//
//  Created by Tejas Mehta on 1/15/21.
//

import Foundation
import Security

public class Salt {
    
    let bytes: [UInt8]
    
    public init(bytes: [UInt8]) {
        self.bytes = bytes
    }
    
    public static func newSalt(length: Int = 16) -> Salt {
        // Set a byte array
        var bytes = [UInt8](repeating: 0, count: length)
        // Set random generated numbers to the byte array
        let status = SecRandomCopyBytes(kSecRandomDefault, bytes.count, &bytes)
        // Ensure the copy was a success
        if status != errSecSuccess {
            
        }
        // Return the salt
        return Salt(bytes: bytes)
    }
}
