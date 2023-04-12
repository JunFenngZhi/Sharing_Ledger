//
//  StorageModel.swift
//  SharingLedger
//
//  Created by mac on 2023/3/28.
//

import Foundation

class StorageModel: ObservableObject { //TODO: add to firestore
    @Published var personInfo: [String: PersonDetail] = [:]
    @Published var allEvents: [String: EventInfo] = [:]
    
    init(){
        initForTest()
    }
    
    func initForTest(){
        self.allEvents["Development"] = EventInfo(name: "Development")
    }
}
