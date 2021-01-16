//
//  Argon2.swift
//  Argon2Swift
//
//  Created by Tejas Mehta on 1/15/21.
//

import Foundation

public class Argon2Swift {
    
    public init() {}
    
    public func hashPasswordString(password: String, salt: Salt, iterations: Int = 32, memory: Int = 256, parallelism: Int = 2, length: Int = 32, type: Argon2Type = .i, version: Argon2Version = .V13) -> Argon2SwiftResult {
        guard let passData = password.data(using: .utf8) else {
            // TODO throw exception
            return Argon2SwiftResult(hashBytes: [], encodedBytes: []);
        }
        return hashPasswordBytes(password: passData, salt: salt, iterations: iterations, memory: memory, parallelism: parallelism, length: length, type: type, version: version)
    }
    
    public func hashPasswordBytes(password: Data, salt: Salt, iterations: Int = 32, memory: Int = 256, parallelism: Int = 2, length: Int = 32, type: Argon2Type = .i, version: Argon2Version = .V13) -> Argon2SwiftResult {
        
        let encodedLen = argon2_encodedlen(UInt32(iterations), UInt32(memory), UInt32(parallelism), UInt32(32), UInt32(length), Argon2_id)
        let hash = setPtr(length: length)
        let encoded = setPtr(length: encodedLen)

        let hashVal = argon2_hash(UInt32(iterations), UInt32(memory), UInt32(parallelism), [UInt8](password), password.count, salt.bytes, salt.bytes.count, hash, length, encoded, encodedLen, getArgon2Type(type: type), UInt32(version.rawValue))
        
        if hashVal != 0 {
            print("Success")
        }
        
        let hashArray = Array(UnsafeBufferPointer(start: hash, count: length))
        let encodedArray = Array(UnsafeBufferPointer(start: encoded, count: encodedLen))

        
        let result = Argon2SwiftResult(hashBytes: hashArray, encodedBytes: encodedArray)
        
        freePtr(pointer: hash, length: length)
        freePtr(pointer: encoded, length: encodedLen)
        
        return result
    }
    
    public func verifyPasswordString() {
        
    }
    
    public func verifyPasswordBytes() {
        
    }

    
    func getArgon2Type(type: Argon2Type) -> Argon2_type {
        var argonType = Argon2_i
        if (type == .d) {
            argonType = Argon2_d
        }
        if (type == .id) {
            argonType = Argon2_id
        }
        return argonType
    }
    
    func setPtr(length: Int) -> UnsafeMutablePointer<Int8> {
        return UnsafeMutablePointer<Int8>.allocate(capacity: length)
    }
    
    func freePtr(pointer: UnsafeMutablePointer<Int8>, length: Int) {
        pointer.deinitialize(count: length)
        pointer.deallocate()
    }
    
}
