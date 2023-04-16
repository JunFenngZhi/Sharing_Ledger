//
//  EventDetails.swift
//  SharingLedger
//
//  Created by Loaner on 3/29/23.
//

import SwiftUI

struct EventDetailsView: View {
    let eventID: String
    var eventName: String{
        return storageModel.allEvents[eventID]!.eventname
    }
    
    @EnvironmentObject var storageModel: StorageModel
    @Binding var viewType: ViewType
    
    var body: some View {
        let event: EventInfo = storageModel.allEvents[eventID]!
        VStack{
            HStack{
                Text(eventName)
                    .font(.headline)
                    .fontWeight(.heavy)
                Spacer()
                OverlapPersonPicture(personIdList: event.participates)
            }
            .padding([.trailing, .leading])
            
            EventSummary(eventID: eventID, viewType: $viewType)
            
            List{
                ForEach(event.payments.sorted(by: dateComparator), id: \.self) { id in
                    let payment = storageModel.allPayments[id]!
                    NavigationLink {
                        PaymentDetailsView(eventID: eventID, payment: payment)
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
            }
            .buttonStyle(GrowingButton(backGroundColor: themeColor, foreGroundColor: .white))
        }
    }
    
    private func dateComparator(_ lhs: String, _ rhs: String) ->Bool{
        return storageModel.allPayments[lhs]!.time > storageModel.allPayments[rhs]!.time
    }
}

struct EventDetailsView_Previews: PreviewProvider {
    @State static var viewType: ViewType = .EventDetailsView
    static var previews: some View {
        EventDetailsView(eventID: "Development_ID", viewType: $viewType).environmentObject(StorageModel())
    }
}
