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
        var bytes = [UInt8](repeating: 0, count: length)
        let status = SecRandomCopyBytes(kSecRandomDefault, bytes.count, &bytes)
        if status != errSecSuccess {
            
        }
        return Salt(bytes: bytes)
    }
}
