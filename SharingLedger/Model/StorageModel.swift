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
        let payments_1 = PaymentsDetail(paymentName: "chick-fil-a", expense: 20, category: .Restaurant, participates: ["Junfeng Zhi", "Dingzhou Wang", "Suchuan Xing"], payers: ["Junfeng Zhi"], note: "lunch", time: Date.now)
        let payments_2 = PaymentsDetail(paymentName: "nuro taco", expense: 40, category: .Restaurant, participates: ["Junfeng Zhi", "Dingzhou Wang", "Suchuan Xing"], payers: ["Suchuan Xing"], note: "dinner", time: Date.now)
        self.allEvents["Development"]?.payments["chick-fil-a"] = payments_1
        self.allEvents["Development"]?.payments["nuro taco"] = payments_2
        //self.allEvents["Development"]?.conclusion.totalExpense += payments_1.expense + payments_2.expense
        
        personInfo["Suchuan Xing"] = PersonDetail(id: "a", lname: "Xing", fname: "Suchuan", joinedEventNames: [])
        personInfo["Dingzhou Wang"] = PersonDetail(id: "b", lname: "Wang", fname: "Dingzhou", joinedEventNames: [])
        personInfo["Junfeng Zhi"] = PersonDetail(id: "c", lname: "Zhi", fname: "Junfeng", joinedEventNames: [])
    }
    
    
    private func buildPersonDetailFromDukePerson(dukePerson: DukePerson) -> PersonDetail{
        var id: String = dukePerson.firstname + " " + dukePerson.lastname
        var lname: String = dukePerson.lastname
        var fname: String = dukePerson.firstname
        var personDetail: PersonDetail = PersonDetail(id: id, lname: lname, fname: fname, joinedEventNames: [])
        personDetail.picture = dukePerson.picture
        return personDetail
    }
    
    func initFromDukeStorageModel(dukeStorageModel: DukeStorageModel){
        for netid in dukeStorageModel.personDict.keys {
            var dukePerson: DukePerson = dukeStorageModel.personDict[netid]!
            var personDetail: PersonDetail = buildPersonDetailFromDukePerson(dukePerson: dukePerson)
            personInfo[personDetail.firstname + " " + personDetail.lastname] = personDetail
        }
    }
}
