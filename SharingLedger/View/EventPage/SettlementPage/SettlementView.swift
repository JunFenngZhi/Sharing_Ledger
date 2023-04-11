//
//  SettlementView.swift
//  SharingLedger
//
//  Created by Loaner on 4/10/23.
//

import SwiftUI

struct SettlementView: View {
    let eventName: String
    
    @EnvironmentObject var storageModel: StorageModel
    @Environment(\.presentationMode) var presentationMode
    
    @State var selectedRow: Int?

    //TODO: add a back button using toolbar?
    var body: some View {
        let event: EventInfo = storageModel.allEvents[eventName]!
        let conclusion: EventConclusion = event.conclusion
        VStack{
            Text("Event Expense Settlement").font(.title).bold()
            Text("Reminder: This app only provides the settlement plan. The actual payments need to be done using other methods, like transfering through venmo or zelle.")
                .font(.subheadline).foregroundColor(.gray)
            
            List{
                ForEach(event.participates.indices) { index in
                    let personName = event.participates[index]
                    VStack {
                        PersonRow(picture: Image("Unknown"), name: personName, amount: conclusion.personExpense[personName]!, index: index, selectedRow: $selectedRow)
                            .padding(.vertical, 10).padding(.leading, -10)
                        .onTapGesture {
                            selectedRow = selectedRow == index ? nil : index
                        }
                        
                        // details
                        if selectedRow == index {
                            Text("Details for Row \(index + 1)")
                        }
                    }
                }
            }
        }
    }
}

struct SettlementView_Previews: PreviewProvider {
    static var previews: some View {
        SettlementView(eventName: "Development").environmentObject(StorageModel())
    }
}
