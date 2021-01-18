// Copyright 2020 Tejas Mehta <tmthecoder@gmail.com>
// Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
// The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.


import Foundation

public class Argon2Swift {
    
    public init() {}
    
    public func hashPasswordString(password: String, salt: Salt, iterations: Int = 32, memory: Int = 256, parallelism: Int = 2, length: Int = 32, type: Argon2Type = .i, version: Argon2Version = .V13) throws -> Argon2SwiftResult {
        // Convert the password to a data type by utilizing utf8
        guard let passData = password.data(using: .utf8) else {
            // TODO throw exception
            return Argon2SwiftResult(hashBytes: [], encodedBytes: []);
        }
        // Perform the hash with the hashPasswordBytes method with the converted password
        return try hashPasswordBytes(password: passData, salt: salt, iterations: iterations, memory: memory, parallelism: parallelism, length: length, type: type, version: version)
    }
    
    public func hashPasswordBytes(password: Data, salt: Salt, iterations: Int = 32, memory: Int = 256, parallelism: Int = 2, length: Int = 32, type: Argon2Type = .i, version: Argon2Version = .V13) throws -> Argon2SwiftResult {
        
        // get length of encoded result
        let encodedLen = argon2_encodedlen(UInt32(iterations), UInt32(memory), UInt32(parallelism), UInt32(32), UInt32(length), Argon2_id)
        // Allocate a pointer for the hash and the encoded hash
        let hash = setPtr(length: length)
        let encoded = setPtr(length: encodedLen)

        // Perform the actual hash operation
        let errorCode = argon2_hash(UInt32(iterations), UInt32(memory), UInt32(parallelism), [UInt8](password), password.count, salt.bytes, salt.bytes.count, hash, length, encoded, encodedLen, getArgon2Type(type: type), UInt32(version.rawValue))
        
        // Check if there were any errors
        if errorCode != Argon2SwiftErrorCode.ARGON2_OK.rawValue {
            let errorMsg = String(cString: argon2_error_message(errorCode))
            throw Argon2SwiftException(errorMsg, errorCode: Argon2SwiftErrorCode(rawValue: errorCode) ?? Argon2SwiftErrorCode.ARGON2_UNKNOWN_ERROR)
        }
        
        // Create copy arrays for the hash and encoded results
        let hashArray = Array(UnsafeBufferPointer(start: hash, count: length))
        let encodedArray = Array(UnsafeBufferPointer(start: encoded, count: encodedLen))
        
        // Create an instance of Argon2SwiftResult with the arrays
        let result = Argon2SwiftResult(hashBytes: hashArray, encodedBytes: encodedArray)
        
        // Free the previously created pointers
        freePtr(pointer: hash, length: length)
        freePtr(pointer: encoded, length: encodedLen)
        
        // Return the result from above
        return result
    }
    
    public func verifyPasswordString(password: String, encoded: String, type: Argon2Type) throws -> Bool {
        // Convert the password to a data type by utilizing utf8
        guard let passData = password.data(using: .utf8) else {
            return false
        }
        // Convert the encoded to a data type by utilizing utf8
        guard let encodedData = encoded.data(using: .utf8) else {
            return false
        }
        return try verifyPasswordBytes(password: passData, encoded: encodedData, type: type)
    }
    
    public func verifyPasswordBytes(password: Data, encoded: Data, type: Argon2Type) throws -> Bool {
        // Convert encoded to a c string
        let encodedStr = String(data: encoded, encoding: .utf8)?.cString(using: .utf8)
        // Get the verified result
        let result = argon2_verify(encodedStr, [UInt8](password), password.count, getArgon2Type(type: type))
        if result != Argon2SwiftErrorCode.ARGON2_OK.rawValue {
            let errorMsg = String(cString: argon2_error_message(result))
            throw Argon2SwiftException(errorMsg, errorCode: Argon2SwiftErrorCode(rawValue: result) ?? Argon2SwiftErrorCode.ARGON2_UNKNOWN_ERROR)
        }
        // Return if it's verified or not
        return result == 0
    }

    
    func getArgon2Type(type: Argon2Type) -> Argon2_type {
        // Check what type was supplied and return the corresponding Argon2_type object
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
        // Create and allocate a pointer with the given length
        return UnsafeMutablePointer<Int8>.allocate(capacity: length)
    }
    
    func freePtr(pointer: UnsafeMutablePointer<Int8>, length: Int) {
        // Deinitialize and deallocate a pointer of the given length
        pointer.deinitialize(count: length)
        pointer.deallocate()
    }
    
}
