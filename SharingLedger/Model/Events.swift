//
//  Events.swift
//  SharingLedger
//
//  Created by mac on 2023/3/26.
//

import Foundation

class Note {
    //Note contains text notes and picture notes
    var texts: [String]
    var pictures: [String]
    
    init(text: String) {
        self.texts = [text]
        self.pictures = []
    }
}

enum Category: String{
    case Restaurant = "Restaurant"
    case Shopping = "Shopping"
    case Traffic = "Traffic"
    case Hotel = "Hotel"
    case Tickets = "Tickets"
}


class PaymentsDetail {
    var paymentName: String
    var expense: Double
    var category: Category
    //participates contains the names of person
    var participates: [String] // TODO: need to guarantee names are correct
    //payers contains the names of person
    var payers: [String]
    //note contains text notes and picture notes. we only handle text notes for now.
    var note: Note
    var time: Date
    
    init(paymentName: String, expense: Double, category: Category, participates: [String],
         payers: [String], note: String, time: Date) {
        self.paymentName = paymentName
        self.expense = expense
        self.category = category
        self.participates = participates
        self.payers = payers
        self.note = Note(text: note)
        self.time = time
    }
}



class EventConclusion {
    var totalExpense: Double
    //may contain other info
    init() {
        self.totalExpense = 0
    }
}

class EventInfo {
    var eventname: String
    var conclusion: EventConclusion
    var payments: [String: PaymentsDetail]
    var participates: [String]  //TODO: check participates are not repeated?
    
    init(name: String) {
        self.eventname = name
        self.conclusion = EventConclusion()
        self.payments = [:]
        self.participates = []
        
        initForTest() // only for preview test
    }
    
    private func initForTest() {
        self.participates = ["Junfeng Zhi", "Dingzhou Wang", "Suchuan Xing","youKnowWho"]
        let payments_1 = PaymentsDetail(paymentName: "chick-fil-a", expense: 23.45, category: .Restaurant, participates: ["Junfeng Zhi", "Dingzhou Wang", "Suchuan Xing"], payers: ["Junfeng Zhi"], note: "lunch", time: Date.now)
        let payments_2 = PaymentsDetail(paymentName: "nuro taco", expense: 45.67, category: .Restaurant, participates: ["Junfeng Zhi", "Dingzhou Wang", "Suchuan Xing"], payers: ["Suchuan Xing"], note: "dinner", time: Date.now)
        self.payments["chick-fil-a"] = payments_1
        self.payments["nuro taco"] = payments_2
        self.conclusion.totalExpense += payments_1.expense + payments_2.expense
    }
    
}

class AllEvents {
    //The key of eventDict is eventname
    var eventDict: [String: EventInfo] = [:]
}
