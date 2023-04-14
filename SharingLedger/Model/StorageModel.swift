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
    @Published var allPayments: [String: PaymentsDetail] = [:]
    
    init(){
        initForTest()
    }
    
    func initForTest(){
        self.allEvents["Development"] = EventInfo(eventName: "Development", participates: ["Junfeng Zhi", "Dingzhou Wang", "Suchuan Xing"])
        let payments_1 = PaymentsDetail(paymentName: "chick-fil-a", expense: 20, category: .Restaurant, participates: ["Junfeng Zhi", "Dingzhou Wang", "Suchuan Xing"], payers: ["Junfeng Zhi"], note: "lunch", time: Date.now)
        let payments_2 = PaymentsDetail(paymentName: "nuro taco", expense: 40, category: .Restaurant, participates: ["Junfeng Zhi", "Dingzhou Wang", "Suchuan Xing"], payers: ["Suchuan Xing"], note: "dinner", time: Date.now)
        self.allEvents["Development"]?.payments["chick-fil-a"] = payments_1
        self.allEvents["Development"]?.payments["nuro taco"] = payments_2
        //self.allEvents["Development"]?.conclusion.totalExpense += payments_1.expense + payments_2.expense
        
        var suchuan_pic: String = personInfo["Suchuan Xing"]?.picture ?? "No pic"
        var dingzhou_pic: String = personInfo["Dingzhou Wang"]?.picture ?? "No pic"
        var junfeng_pic: String = personInfo["Junfeng Zhi"]?.picture ?? "No pic"
        personInfo["Suchuan Xing"] = PersonDetail(id: "Suchuan Xing", lname: "Xing", fname: "Suchuan", joinedEventNames: ["Development"])
        personInfo["Dingzhou Wang"] = PersonDetail(id: "Dingzhou Wang", lname: "Wang", fname: "Dingzhou", joinedEventNames: ["Development"])
        personInfo["Junfeng Zhi"] = PersonDetail(id: "Junfeng Zhi", lname: "Zhi", fname: "Junfeng", joinedEventNames: ["Development"])
        
        personInfo["Suchuan Xing"]!.picture = suchuan_pic
        personInfo["Dingzhou Wang"]!.picture = dingzhou_pic
        personInfo["Junfeng Zhi"]!.picture = junfeng_pic
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
