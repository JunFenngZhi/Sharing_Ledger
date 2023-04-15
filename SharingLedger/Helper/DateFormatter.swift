//
//  DateFormatter.swift
//  SharingLedger
//
//  Created by Loaner on 4/14/23.
//

import Foundation

extension DateFormatter {
    static let dateTime: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .medium
        return formatter
    }()
}
