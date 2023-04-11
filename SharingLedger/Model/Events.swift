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
    var personExpense: [String: Double] = [:]  // count the amount of expense for each participants. Expense = spend - pay
    var allSettlementResults: [String: [(String,Double)]] =  [:] // {a:[b pays a 100],[c pays a 50]...}
    
    init(participates: [String]) {
        self.totalExpense = 0
        for personName in participates{
            personExpense[personName] = 0
            allSettlementResults[personName] = []
        }
    }
    
    func settle(){
        //TODO: calculate transferList, this function needs to be called when enter settle page,
    }
    //TODO: totalExpense, personExpense needs to be updated when add/delete payments
    //TODO: EventConclusion needs to update if more people are invited to current event.
}

class EventInfo {
    var eventname: String
    var conclusion: EventConclusion
    var payments: [String: PaymentsDetail] = [:]
    var participates: [String]  //TODO: check participates are not repeated?
    
    init(eventName: String, participates: [String]) {
        self.eventname = eventName
        self.participates = participates
        self.conclusion = EventConclusion(participates: participates)
    }

}

class AllEvents {
    //The key of eventDict is eventname
    var eventDict: [String: EventInfo] = [:]
}
