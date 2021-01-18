// Copyright 2020 Tejas Mehta <tmthecoder@gmail.com>
// Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
// The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.


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
