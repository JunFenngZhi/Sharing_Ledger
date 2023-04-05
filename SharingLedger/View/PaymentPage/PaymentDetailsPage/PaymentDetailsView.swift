//
//  PaymentDetails.swift
//  SharingLedger
//
//  Created by Loaner on 3/29/23.
//

import SwiftUI

struct PaymentDetailsView: View {
    let payment: PaymentsDetail
    var body: some View {
        VStack{
            VStack(alignment: .leading){
                //Text(DateFormatter().string(from: payment.time))
                HStack{
                    SmallCircleImage(image: Image("Unknown"), width: 50, height: 50, shadowRadius: 7)
                    Text(payment.paymentName).font(.headline)
                    Spacer()
                    Button("Edit✏️") {
                    }
                    .buttonStyle(GrowingButton(backGroundColor: themeColor, foreGroundColor: .white))
                }
                .padding()
                
                Text("$" + String(format:"%.2f", payment.expense))
                    .font(.title)
                    .bold()
                    .padding(.leading)
            }
            
            Spacer()
            Rectangle().fill(Color(UIColor.systemGroupedBackground))
                .frame(height: 16)

            List(){
                Section(header: Text("Participants: ").font(.subheadline).foregroundColor(.cyan).bold()){
                    ForEach(payment.participates.indices){
                        ParticipantRow(name: payment.participates[$0], amount: Double(payment.expense)/Double(payment.participates.count))
                    }
                }
                .listRowInsets(EdgeInsets())
                
                Section(header: Text("Payers: ").font(.subheadline).foregroundColor(.cyan).bold()){
                    ForEach(payment.payers.indices){
                        PayerRow(name: payment.payers[$0])
                    }
                }
                .listRowInsets(EdgeInsets())

                Section(header: Text("Notes: ").font(.subheadline).foregroundColor(.cyan).bold()){
                    Text(payment.note.texts[0]).padding(.horizontal)
                }
                .listRowInsets(EdgeInsets())
            }
            .padding(.horizontal, -15.0)
            .padding(.top, -9.0)
            
            Button("Delete🗑") {
                //TODO: delte this payment
            }
            .buttonStyle(GrowingButton(backGroundColor: .red, foreGroundColor: .white))
        }
    }
}

struct PaymentDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        PaymentDetailsView(payment: PaymentsDetail(paymentName: "chick-fil-a", expense: 23.45, category: .Restaurant, participates: ["Junfeng Zhi", "Dingzhou Wang", "Suchuan Xing"], payers: ["Junfeng Zhi"], note: "lunch", time: Date.now))
    }
}
