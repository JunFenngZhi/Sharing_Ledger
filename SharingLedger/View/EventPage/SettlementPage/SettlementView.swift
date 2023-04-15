//
//  SettlementView.swift
//  SharingLedger
//
//  Created by Loaner on 4/10/23.
//

import SwiftUI

struct SettlementView: View {
    let eventID: String
    
    @EnvironmentObject var storageModel: StorageModel
    
    @State var selectedRow: Int?
    @Binding var viewType: ViewType
    
    // [personID: expenseAmount] count the amount of expense for each participants. Expense = spend - pay
    var personExpenseList: [String: Double]{
        let event = storageModel.allEvents[eventID]!
        let allParticipatesID: [String] = event.participates
        let allPaymentIDs = event.payments
        var dict: [String: Double] = [:]
        
        // init
        for personID in allParticipatesID{
            dict[personID] = 0
        }
        
        // calculate personExpenseList
        for id in allPaymentIDs{
            let paymentDetails = storageModel.allPayments[id]!
            
            for pName in paymentDetails.participates{
                dict[pName]! += paymentDetails.expense / Double(paymentDetails.participates.count)
            }
            for pName in paymentDetails.payers{
                dict[pName]! -= paymentDetails.expense / Double(paymentDetails.payers.count)
            }
        }
        
        return dict
    }
    
    // {ID_personA: (ID_personB, 100), (ID_personC, -50]...}
    var allSettlementResults: [String: [(String,Double)]]{
        var dict: [String: [(String,Double)]] = [:]
        let event = storageModel.allEvents[eventID]!
        let allParticipatesID: [String] = event.participates
        let allPaymentIDs = event.payments
        
        // init
        for personID in allParticipatesID{
            dict[personID] = []
        }
        
        // calculate allSettlementResults
        let sortedKeys = personExpenseList.keys.sorted()
        var personExpenseListCopy = personExpenseList
        for curPersonID in sortedKeys{
            let curExpense = personExpenseListCopy[curPersonID]!
            
            if(curExpense > 0 && isZero_Double(num: curExpense) == false){  // cur person should pay others
                let otherPersonList = sortedKeys.filter { p in p != curPersonID}
                for otherPersonID in otherPersonList{
                    let otherExpense = personExpenseListCopy[otherPersonID]!
                    
                    if(otherExpense < 0 && isZero_Double(num: otherExpense) == false){ // other person should get money. curPerson pays otherPerson
                        let payAmount = min(abs(otherExpense), abs(curExpense))
                        personExpenseListCopy[curPersonID]! -= payAmount
                        personExpenseListCopy[otherPersonID]! += payAmount
                        dict[curPersonID]?.append((otherPersonID, payAmount))
                        dict[otherPersonID]?.append((curPersonID, -1 * payAmount))
                    }
                    if(isZero_Double(num: personExpenseListCopy[curPersonID]!) == true){
                        break
                    }
                }
            }
        }
        return dict
    }

    
    var body: some View {
        let event: EventInfo = storageModel.allEvents[eventID]!
        
        VStack{
            HStack{
                backButton
                Text("Settlement Page").font(.title2).bold()
                    .offset(x:30)
                Spacer()
            }.background(themeColor)
            
            Text("Reminder: This app only provides the settlement plan. The actual payments need to be done using other methods, like transfering through venmo or zelle.")
                .font(.subheadline)
                .foregroundColor(.gray)
                .padding(.vertical, -5)
            
            List{
                ForEach(event.participates.indices) { index in
                    let personID = event.participates[index]
                    let personInfo = storageModel.personInfo[personID]!
                    let personName = personInfo.firstname + " " + storageModel.personInfo[personID]!.lastname

                    VStack {
                        PersonRow(picture: Image(uiImage: imageFromString(personInfo.picture)), name: personName, payAmount: personExpenseList[personID]!, index: index, selectedRow: $selectedRow)
                        .padding(.vertical, 10)
                        .padding(.leading, -10)
                        .onTapGesture {
                            selectedRow = selectedRow == index ? nil : index
                        }
                        
                        // settlement details for each person
                        if selectedRow == index {
                            DetailsView(myPersonID: personID, transferList: allSettlementResults[personID]!)
                            .padding(.horizontal, -40)
                            .padding(.vertical)
                        }
                    }
                }
                .listRowBackground(Color.white)
            }
        }
       
    }
    
    private var backButton: some View {
        Button(action: {
            viewType = .EventDetailsView
        }, label: {
            HStack {
                Image(systemName: "chevron.backward").bold()
                Text("Event")
                    .offset(x: -5)
            }
        })
        .foregroundColor(.blue)
        .padding(.leading, 10)
    }
}

struct SettlementView_Previews: PreviewProvider {
    @State static var viewType: ViewType = .SettlementView
    static var previews: some View {
        SettlementView(eventID: "Development_ID", viewType: $viewType).environmentObject(StorageModel())
    }
}
