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
    
    var body: some View {
        let curEvent = storageModel.allEvents[eventName]!
        HStack{
            VStack(alignment: .leading){
                Text("$" + String(format:"%.2f",curEvent.conclusion.totalExpense))
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
                curEvent.conclusion.settle(participates: curEvent.participates, allPayments: curEvent.payments)
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
