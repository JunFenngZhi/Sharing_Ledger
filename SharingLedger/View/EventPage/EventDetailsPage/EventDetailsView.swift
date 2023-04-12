//
//  EventDetails.swift
//  SharingLedger
//
//  Created by Loaner on 3/29/23.
//

import SwiftUI

struct EventDetailsView: View {
    let eventName: String
    
    @EnvironmentObject var storageModel: StorageModel
    @Binding var viewType: ViewType
    
    var body: some View {
        let event: EventInfo = storageModel.allEvents[eventName]!
        NavigationView {
            VStack{
                HStack{
                    Text(eventName)
                        .font(.headline)
                        .fontWeight(.heavy)
                    Spacer()
                    OverlapPersonPicture(nameList: event.participates)
                }
                .padding([.trailing, .leading])
                
                EventSummary(totalExpense: event.conclusion.totalExpense, viewType: $viewType)
                
                List{
                    ForEach(Array(event.payments.keys), id: \.self) { name in // TODO: payments order may varied. sorted by key/time
                        NavigationLink {
                            PaymentDetailsView(payment: event.payments[name]!)
                        } label: {
                            PaymentRow(payment: event.payments[name]!)
                        }.listRowInsets(EdgeInsets())
                    }
                }
                .padding(.horizontal, -15.0)
                .padding(.top, -10.0)
                
                
                Button("New Payment") {
                    viewType = .NewPaymentView
                    print("Button pressed!")
                }
                .buttonStyle(GrowingButton(backGroundColor: themeColor, foreGroundColor: .white))
            }
            
        }
    }
}

struct EventDetailsView_Previews: PreviewProvider {
    @State static var viewType: ViewType = .EventDetailsView
    static var previews: some View {
        EventDetailsView(eventName: "Development", viewType: $viewType).environmentObject(StorageModel())
    }
}
