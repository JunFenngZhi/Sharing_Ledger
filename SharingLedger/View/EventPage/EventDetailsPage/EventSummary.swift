//
//  EventSummary.swift
//  SharingLedger
//
//  Created by Loaner on 3/29/23.
//

import SwiftUI

struct EventSummary: View {
    let eventName: String
    
    @Binding var viewType: ViewType
    @EnvironmentObject var storageModel: StorageModel
    
    var totalExpense: Double{
        var total: Double = 0
        let curEvent = storageModel.allEvents[eventName]!
        for paymentID in curEvent.payments{
            total += storageModel.allPayments[paymentID]!.expense
        }
        return total
    }
    
    var body: some View {
        let curEvent = storageModel.allEvents[eventName]!
        HStack{
            VStack(alignment: .leading){
                Text("$" + String(format:"%.2f",totalExpense))
                    .font(.title)
                    .bold()
                    .foregroundColor(.white)
                Text("Total Expenses")
                    .foregroundColor(.white)
            }
            .padding(.horizontal)
            
            Spacer()
            
            Button(action: {
                print("click settle")
                withAnimation {
                    viewType = .SettlementView
                }
            }, label: {
                Text("Settle >")
                    .foregroundColor(.white)
                    .bold()
            })
            .padding()
        }
        .frame(height: 100)
        .background(themeColor)
    }
}

struct EventSummary_Previews: PreviewProvider {
    @State static var viewType: ViewType = .EventDetailsView
    static var previews: some View {
        EventSummary(eventName: "Development", viewType: $viewType).environmentObject(StorageModel())
    }
}
