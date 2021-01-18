//
//  Argon2SwiftTests.swift
//  Argon2Swift
//
//  Created by Tejas Mehta on 1/18/21.
//

import Foundation
import XCTest
import Argon2Swift

class Argon2SwiftTests: XCTestCase {
    func testArgon2i() {
        
    }
    
    func testArgon2d() {
        
    }
    
    func testArgon2id() {
        
    }
    
    func hashTest(password: String, salt: String, iterations: Int, memory: Int, parallelism: Int, type: Argon2Type, version: Argon2Version, encodedHash: String, hexHash: String) -> Argon2SwiftErrorCode {
        let s = Salt(Data(salt.utf8))
        var resultString : Argon2SwiftResult
        var resultBytes : Argon2SwiftResult
        // Perform the hash
        do {
            resultString = try Argon2Swift.hashPasswordString(password: password, salt: s, iterations: iterations, memory: memory, parallelism: parallelism, type: type, version: version)
            resultBytes = try Argon2Swift.hashPasswordBytes(password: Data(password.utf8), salt: s, iterations: iterations, memory: memory, parallelism: parallelism, type: type, version: version)
        } catch {
            // Return error
            return (error as? Argon2SwiftException)?.errorCode
        }
        
        // Check for equality between both hashes
        if resultString.encodedString() != resultBytes.encodedString() {
            return Argon2SwiftErrorCode.ARGON2_UNKNOWN_ERROR
        }
        
        // Check if the hex strings match
        if resultBytes.hexString() != hexHash || resultString.hexString() != hexHash {
            return Argon2SwiftErrorCode.ARGON2_UNKNOWN_ERROR
        }
        
        // Check if verification of both methods match
        if (!Argon2Swift.verifyHashString(password: password, hash: encodedHash, type: type) || !Argon2Swift.verifyHashBytes(password: Data(password.utf8), hash: Data(encodedHash.utf8), type: type)) {
            return Argon2SwiftErrorCode.ARGON2_UNKNOWN_ERROR
        }
        
        // Check if they verify against each other
        if (!Argon2Swift.verifyHashString(password: password, hash: resultBytes.encodedString(), type: type) || !Argon2Swift.verifyHashString(password: password, hash: resultString.encodedString(), type: type)) {
            return Argon2SwiftErrorCode.ARGON2_UNKNOWN_ERROR
        }
        
        // All verified
        return Argon2SwiftErrorCode.ARGON2_OK
    }
}
