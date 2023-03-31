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
                    Text("Event Name")
                        .font(.headline)
                        .fontWeight(.heavy)
                    Spacer()
                    OverlapPersonPicture(nameList: ["Junfeng", "DingZhou", "Suchuan"]) //TODO:
                }
                .padding([.trailing, .leading])
                
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
                .buttonStyle(GrowingButton(backGroundColor: themeColor, foreGroundColor: .white))
            }
            
        }
    }
}

struct EventDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        EventDetailsView()
    }
}
