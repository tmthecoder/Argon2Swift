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
        XCTAssertEqual(hashTest(version: .V13, iterations: 2, memory: 16, parallelism: 1, password: "passwors", salt: "somesalt", hexHash: "03df1d13e10203bcc663405e31ab1687939730c9152459bca28fd10c23e38f50", encodedHash: "$argon2i$v=19$m=16,t=2,p=1$c29tZXNhbHQ$A98dE+ECA7zGY0BeMasWh5OXMMkVJFm8oo/RDCPjj1A",type: .i), Argon2SwiftErrorCode.ARGON2_OK, "Argon2i: v = ${0x13}, t = 2, m = 16, p = 1")
        
        XCTAssertEqual(hashTest(version: .V13, iterations: 2, memory: 18, parallelism: 1, password: "passwors", salt: "somesalt", hexHash: "3b1b4ad0a66b3f00b4cd04225e4e6da950ee152bf0d29aabcb123c2f1a90567a", encodedHash: "$argon2i$v=19$m=18,t=2,p=1$c29tZXNhbHQ$OxtK0KZrPwC0zQQiXk5tqVDuFSvw0pqryxI8LxqQVno",type: .i), Argon2SwiftErrorCode.ARGON2_OK, "Argon2i: v = ${0x13}, t = 2, m = 18, p = 1")
        
        XCTAssertEqual(hashTest(version: .V13, iterations: 2, memory: 8, parallelism: 1, password: "passwors", salt: "somesalt", hexHash: "48cc13c16c5a2d254a278e2c44420ba0fb2d0f070661e35d6486604a7a2ff1a9", encodedHash: "$argon2i$v=19$m=8,t=2,p=1$c29tZXNhbHQ$SMwTwWxaLSVKJ44sREILoPstDwcGYeNdZIZgSnov8ak",type: .i), Argon2SwiftErrorCode.ARGON2_OK, "Argon2i: v = ${0x13}, t = 2, m = 8, p = 1")
        
        XCTAssertEqual(hashTest(version: .V13, iterations: 2, memory: 16, parallelism: 2, password: "passwors", salt: "somesalt", hexHash: "7fbb85db7e9636115f2fd0f29ea4214baaada18b39fffed7875eeb9fa9b308c5", encodedHash: "$argon2i$v=19$m=16,t=2,p=2$c29tZXNhbHQ$f7uF236WNhFfL9DynqQhS6qtoYs5//7Xh17rn6mzCMU",type: .i), Argon2SwiftErrorCode.ARGON2_OK, "Argon2i: v = ${0x13}, t = 2, m = 16, p = 2")
    }
    
    func testArgon2d() {
        
    }
    
    func testArgon2id() {
        
    }
    
    func hashTest(version: Argon2Version, iterations: Int, memory: Int, parallelism: Int, password: String, salt: String, hexHash: String, encodedHash: String, type: Argon2Type) -> Argon2SwiftErrorCode {
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
