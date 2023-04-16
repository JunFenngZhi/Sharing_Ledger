//
//  EventSummary.swift
//  SharingLedger
//
//  Created by Loaner on 3/29/23.
//

import SwiftUI

struct EventSummary: View {
    let eventID: String
    
    @Binding var viewType: ViewType
    @EnvironmentObject var storageModel: StorageModel
    
    var totalExpense: Double{
        var total: Double = 0
        let curEvent = storageModel.allEvents[eventID]!
        for paymentID in curEvent.payments{
            total += storageModel.allPayments[paymentID]!.expense
        }
        return total
    }
    
    var body: some View {
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
        EventSummary(eventID: "Development_ID", viewType: $viewType).environmentObject(StorageModel())
    }
}
