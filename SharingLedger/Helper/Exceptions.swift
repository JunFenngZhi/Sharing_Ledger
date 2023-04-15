//
//  Exceptions.swift
//  SharingLedger
//
//  Created by Loaner on 4/15/23.
//

import Foundation

enum InputError: Error {
    case invalidArgValue(msg: String)
    case ArgMissing(msg: String)
}
