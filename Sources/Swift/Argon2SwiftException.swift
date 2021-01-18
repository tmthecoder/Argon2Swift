//
//  Argon2SwiftError.swift
//  Pods
//
//  Created by Tejas Mehta on 1/17/21.
//

import Foundation

struct Argon2SwiftException: Error {
    let message: String
    let errorCode: Argon2SwiftErrorCode

    init(_ message: String, errorCode: Argon2SwiftErrorCode) {
        self.errorCode = errorCode
        self.message = message
    }

    public var localizedDescription: String {
        return "[\(errorCode)] \(message)"
    }
}
