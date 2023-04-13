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
    var totalExpense: Double = 0
    var personExpenseList: [String: Double] = [:]  // count the amount of expense for each participants. Expense = spend - pay
    var allSettlementResults: [String: [(String,Double)]] =  [:] // {a:[b pays a 100],[c pays a 50]...}
    
    init(participates: [String]){
        for pName in participates{
            personExpenseList[pName] = 0
            allSettlementResults[pName] = []
        }
    }
    
    /// Calculate settlement results for all the participants. This functon should be called when enter SettlementView.
    func settle(participates: [String], allPayments: [String: PaymentsDetail]){
        // reset
        personExpenseList.removeAll()
        allSettlementResults.removeAll()
        for pName in participates{
            personExpenseList[pName] = 0
            allSettlementResults[pName] = []
        }
        
        // calculate personExpenseList
        for(_, paymentDetails) in allPayments{
            for pName in paymentDetails.participates{
                personExpenseList[pName]! += paymentDetails.expense / Double(paymentDetails.participates.count)
            }
            for pName in paymentDetails.payers{
                personExpenseList[pName]! -= paymentDetails.expense / Double(paymentDetails.payers.count)
            }
        }
        
        // calculate allSettlementResults
        let sortedKeys = personExpenseList.keys.sorted()
        var personExpenseListCopy = personExpenseList
        for curPerson in sortedKeys{
            let curExpense = personExpenseListCopy[curPerson]!
            
            if(curExpense > 0 && isZero_Double(num: curExpense) == false){  // cur person should pay others
                let otherPersonList = sortedKeys.filter { p in p != curPerson}
                for otherPerson in otherPersonList{
                    let otherExpense = personExpenseListCopy[otherPerson]!
                    
                    if(otherExpense < 0 && isZero_Double(num: otherExpense) == false){ // other person should get money. curPerson pays otherPerson
                        let payAmount = min(abs(otherExpense), abs(curExpense))
                        personExpenseListCopy[curPerson]! -= payAmount
                        personExpenseListCopy[otherPerson]! += payAmount
                        allSettlementResults[curPerson]?.append((otherPerson, payAmount))
                        allSettlementResults[otherPerson]?.append((curPerson, -1 * payAmount))
                    }
                    if(isZero_Double(num: personExpenseListCopy[curPerson]!) == true){
                        break
                    }
                }
            }
        }
        
    }
    
    /// Update total expense based on all the payments. This function should be called when EventInfo.payments is updated.
    func updateTotalExpense(allPayments: [String: PaymentsDetail]){
        totalExpense = 0
        for(_, paymentDetails) in allPayments{
            totalExpense += paymentDetails.expense
        }
    }
}

class EventInfo {
    var eventname: String
    var conclusion: EventConclusion
    var payments: [String: PaymentsDetail] = [:] // paymentName: PaymentsDetail.id
    var participates: [String]  //TODO: check participates are not repeated?
    
    init(eventName: String, participates: [String]) {
        self.eventname = eventName
        self.participates = participates
        self.conclusion = EventConclusion(participates: participates)
    }

}

extension EventInfo: Hashable{
    func hash(into hasher: inout Hasher) {
            hasher.combine(eventname)
        }
    
    static func == (lhs: EventInfo, rhs: EventInfo) -> Bool {
        return lhs.eventname == rhs.eventname
    }
    
    
}

class AllEvents { //TODO: add to firestore
    //The key of eventDict is eventname
    var eventDict: [String: EventInfo] = [:]
}
