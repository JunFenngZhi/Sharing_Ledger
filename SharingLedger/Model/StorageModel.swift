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
        self.allEvents["Development"] = EventInfo(eventName: "Development", participates: ["Junfeng Zhi", "Dingzhou Wang", "Suchuan Xing","youKnowWho"])
        let payments_1 = PaymentsDetail(paymentName: "chick-fil-a", expense: 23.45, category: .Restaurant, participates: ["Junfeng Zhi", "Dingzhou Wang", "Suchuan Xing"], payers: ["Junfeng Zhi"], note: "lunch", time: Date.now)
        let payments_2 = PaymentsDetail(paymentName: "nuro taco", expense: 45.67, category: .Restaurant, participates: ["Junfeng Zhi", "Dingzhou Wang", "Suchuan Xing"], payers: ["Suchuan Xing"], note: "dinner", time: Date.now)
        self.allEvents["Development"]?.payments["chick-fil-a"] = payments_1
        self.allEvents["Development"]?.payments["nuro taco"] = payments_2
        self.allEvents["Development"]?.conclusion.totalExpense += payments_1.expense + payments_2.expense
    }
}
