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
        VStack{
            HStack{
                Text(eventName)
                    .font(.headline)
                    .fontWeight(.heavy)
                Spacer()
                OverlapPersonPicture(nameList: event.participates)
            }
            .padding([.trailing, .leading])
            
            EventSummary(eventName: eventName, viewType: $viewType)
            
            
            // TODO: payments order may varied. sorted by key/time
            List{
                ForEach(event.payments, id: \.self) { id in
                    let payment = storageModel.allPayments[id]!
                    NavigationLink {
                        PaymentDetailsView(payment: payment)
                    } label: {
                        PaymentRow(payment: payment)
                    }
                    .listRowInsets(EdgeInsets())
                }
            }
            .padding(.horizontal, -15.0)
            .padding(.top, -10.0)
            
            
            Button("New Payment") {
                withAnimation {
                    viewType = .NewPaymentView
                }
                print("Button pressed!")
            }
            .buttonStyle(GrowingButton(backGroundColor: themeColor, foreGroundColor: .white))
        }
    }
}

struct EventDetailsView_Previews: PreviewProvider {
    @State static var viewType: ViewType = .EventDetailsView
    static var previews: some View {
        EventDetailsView(eventName: "Development", viewType: $viewType).environmentObject(StorageModel())
    }
}
