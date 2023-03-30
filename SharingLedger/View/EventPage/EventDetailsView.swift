//
//  EventDetails.swift
//  SharingLedger
//
//  Created by Loaner on 3/29/23.
//

import SwiftUI

struct EventDetailsView: View {
    var body: some View {
        NavigationView {
            VStack{
                HStack{
                    Text("Ledger Name")
                        .font(.headline)
                        .fontWeight(.heavy)
                    Spacer()
                }
                .padding(.top)
                
                EventSummary(totalExpense: 1234.56)
                
                List{
                    NavigationLink {
                        PaymentDetailsView(payment: PaymentsDetail())
                    } label: {
                        PaymentRow(payment: PaymentsDetail())
                    }.listRowInsets(EdgeInsets())
                }
                .padding(.horizontal, -15.0)
                .padding(.top, -10.0)
                
                Button("New Payment") {
                    print("Button pressed!")
                    //TODO: jump NewPaymentView
                }
                .buttonStyle(GrowingButton(backGroundColor: .blue, foreGroundColor: .white))
            }
            
        }
    }
}

struct EventDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        EventDetailsView()
    }
}
