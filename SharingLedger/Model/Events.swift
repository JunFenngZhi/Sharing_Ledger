//
//  Events.swift
//  SharingLedger
//
//  Created by mac on 2023/3/26.
//

import Foundation

class Note: Codable {
    //Note contains text notes and picture notes
    var texts: [String]
    var pictures: [String]
    
    init(text: String) {
        self.texts = [text]
        self.pictures = []
    }
    
    enum CodingKeys: String, CodingKey {
        case texts
        case pictures
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        texts = try container.decode([String].self, forKey: .texts)
        pictures = try container.decode([String].self, forKey: .pictures)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(texts, forKey: .texts)
        try container.encode(pictures, forKey: .pictures)
    }
}

enum Category: String, Codable {
    case Restaurant = "Restaurant"
    case Shopping = "Shopping"
    case Traffic = "Traffic"
    case Hotel = "Hotel"
    case Tickets = "Tickets"

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let rawValue = try container.decode(String.self)
        self = Category(rawValue: rawValue) ?? .Restaurant
    }
}


class PaymentsDetail: Codable {
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
    
    enum CodingKeys: String, CodingKey {
        case paymentName
        case expense
        case category
        case participates
        case payers
        case note
        case time
    }
    
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
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        paymentName = try container.decode(String.self, forKey: .paymentName)
        expense = try container.decode(Double.self, forKey: .expense)
        category = try container.decode(Category.self, forKey: .category)
        participates = try container.decode([String].self, forKey: .participates)
        payers = try container.decode([String].self, forKey: .payers)
        note = try container.decode(Note.self, forKey: .note)
        time = try container.decode(Date.self, forKey: .time)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(paymentName, forKey: .paymentName)
        try container.encode(expense, forKey: .expense)
        try container.encode(category, forKey: .category)
        try container.encode(participates, forKey: .participates)
        try container.encode(payers, forKey: .payers)
        try container.encode(note, forKey: .note)
        try container.encode(time, forKey: .time)
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
    var payments: [String: PaymentsDetail] // paymentName: PaymentsDetail.id
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

class AllEvents { //TODO: add to firestore
    //The key of eventDict is eventname
    var eventDict: [String: EventInfo] = [:]
}
