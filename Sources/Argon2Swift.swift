//
//  Argon2.swift
//  Argon2Swift
//
//  Created by Tejas Mehta on 1/15/21.
//

import Foundation

public class Argon2Swift {
    public func Argon2Test() {
        argon2_verify(UnsafeRawPointer<Int8>(), UnsafeRawPointer(), 60, Argon2_id)
    }
}
