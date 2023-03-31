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
    
    init() {
        self.texts = [""]
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
    var category: String
    //participates contains the names of person
    var participates: [String]
    //payers contains the names of person
    var payers: [String]
    //note contains text notes and picture notes
    var note: Note
    var time: Date
    
    init() {
        self.paymentName = "Mexico Taco"
        self.expense = 123.45
        self.category = Category.Restaurant.rawValue
        self.participates = ["Junfeng Zhi", "Suchuan Xing", "Dingzhou Wang"]
        self.payers = ["Junfeng Zhi"]
        self.note = Note()
        self.time = Date()
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
    var participates: [String]
    
    
    init(name: String) {
        self.eventname = name
        self.conclusion = EventConclusion()
        self.payments = [:]
        self.participates = []
    }
    
}

class AllEvents {
    //The key of eventDict is eventname
    var eventDict: [String: EventInfo] = [:]
}
