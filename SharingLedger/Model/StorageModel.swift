//
//  StorageModel.swift
//  SharingLedger
//
//  Created by mac on 2023/3/28.
//

import Foundation

class StorageModel: ObservableObject {
    @Published var personInfo: [String: PersonDetail] = [:] // PersonDetail.id : PersonDetail
    @Published var allEvents: [String: EventInfo] = [:] // EventInfo.id : EventInfo
    @Published var allPayments: [String: PaymentsDetail] = [:] // PaymentsDetail.id : PaymentsDetail
    
    init(){
        initForTest()
    }
    
    func initForTest(){
        self.allEvents["Development"] = EventInfo(eventName: "Development", participates: ["Junfeng Zhi_ID", "Dingzhou Wang_ID", "Suchuan Xing_ID"])
        let payments_1 = PaymentsDetail(paymentName: "chick-fil-a", expense: 20, category: .Restaurant, participates: ["Junfeng Zhi_ID", "Dingzhou Wang_ID", "Suchuan Xing_ID"], payers: ["Junfeng Zhi_ID"], note: "lunch", time: Date.now)
        let payments_2 = PaymentsDetail(paymentName: "nuro taco", expense: 40, category: .Restaurant, participates: ["Junfeng Zhi_ID", "Dingzhou Wang_ID", "Suchuan Xing_ID"], payers: ["Suchuan Xing_ID"], note: "dinner", time: Date.now)
        self.allPayments["payments_1_ID"] = payments_1
        self.allPayments["payments_2_ID"] = payments_2
        self.allEvents["Development"]?.payments.append("payments_1_ID")
        self.allEvents["Development"]?.payments.append("payments_2_ID")
        
        var suchuan_pic: String = personInfo["Suchuan Xing_ID"]?.picture ?? "No pic"
        var dingzhou_pic: String = personInfo["Dingzhou Wang_ID"]?.picture ?? "No pic"
        var junfeng_pic: String = personInfo["Junfeng Zhi_ID"]?.picture ?? "No pic"
        
        personInfo["Suchuan Xing_ID"] = PersonDetail(id: "Suchuan Xing", lname: "Xing", fname: "Suchuan", joinedEventNames: ["Development"])
        personInfo["Dingzhou Wang_ID"] = PersonDetail(id: "Dingzhou Wang", lname: "Wang", fname: "Dingzhou", joinedEventNames: ["Development"])
        personInfo["Junfeng Zhi_ID"] = PersonDetail(id: "Junfeng Zhi", lname: "Zhi", fname: "Junfeng", joinedEventNames: ["Development"])
        
        personInfo["Suchuan Xing_ID"]!.picture = suchuan_pic
        personInfo["Dingzhou Wang_ID"]!.picture = dingzhou_pic
        personInfo["Junfeng Zhi_ID"]!.picture = junfeng_pic
    }
    
    
    private func buildPersonDetailFromDukePerson(dukePerson: DukePerson) -> PersonDetail{
        let id: String = dukePerson.firstname + " " + dukePerson.lastname
        let lname: String = dukePerson.lastname
        let fname: String = dukePerson.firstname
        let personDetail: PersonDetail = PersonDetail(id: id, lname: lname, fname: fname, joinedEventNames: [])
        personDetail.picture = dukePerson.picture
        return personDetail
    }
    
    func initFromDukeStorageModel(dukeStorageModel: DukeStorageModel){
        for netid in dukeStorageModel.personDict.keys {
            let dukePerson: DukePerson = dukeStorageModel.personDict[netid]!
            let personDetail: PersonDetail = buildPersonDetailFromDukePerson(dukePerson: dukePerson)
            personInfo[personDetail.firstname + " " + personDetail.lastname] = personDetail
        }
    }
}
