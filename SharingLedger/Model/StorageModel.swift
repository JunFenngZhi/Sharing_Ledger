//
//  StorageModel.swift
//  SharingLedger
//
//  Created by mac on 2023/3/28.
//

import Foundation

class StorageModel: ObservableObject {

    @Published var personInfo: [String: PersonDetail] = [:]
    @Published var allEvents: [String: EventInfo] = [:]
}
