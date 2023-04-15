//
//  NewPaymentViewInputHandle.swift
//  SharingLedger
//
//  Created by Loaner on 4/15/23.
//

import Foundation

func newPaymentViewInputHandle(expenseName: String, expenseAmount: String, category: Category,
                               notes: String, date: Date, selectedPayer: Set<String>,
                               selectedParticipant: Set<String>) throws -> PaymentsDetail {
    if(expenseName.isEmpty){
        throw InputError.invalidArgValue(msg: "Payment name can't be empty.")
    }
    guard let amount = Double(expenseAmount) else{
        throw InputError.invalidArgValue(msg: "Invalid payment amount.")
    }
    if(selectedPayer.isEmpty){
        throw InputError.invalidArgValue(msg: "Payer can not be null.")
    }
    if(selectedParticipant.isEmpty){
        throw InputError.invalidArgValue(msg: "Participant can not be null.")
    }
    
    let newPayment = PaymentsDetail(paymentName: expenseName, expense: amount, category: category, participates: Array(selectedParticipant), payers: Array(selectedPayer), note: notes, time: date)
    
    return newPayment
}

