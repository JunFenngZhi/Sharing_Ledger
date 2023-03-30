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
                    SmallCircleImage(image: Image("Unknown"))
                    Text(payment.paymentName).font(.headline)
                    Spacer()
                    Button("Edit✏️") {
                    }
                    .buttonStyle(GrowingButton(backGroundColor: .blue, foreGroundColor: .white))
                }
                .padding()
                
                Text("$" + String(format:"%.2f", payment.expense))
                    .font(.title)
                    .bold()
                    .padding(.leading)
                //TODO: 加一个间隔
            }
            
            List(){
                Section(header: Text("Participants: ").bold().font(.title2).foregroundColor(.black)){
                    ForEach(payment.participates.indices){
                        ParticipantRow(name: payment.participates[$0], amount: Double(payment.expense)/Double(payment.participates.count))
                    }
                }
                .listRowInsets(EdgeInsets())
                
                Section(header: Text("Payers: ").bold().font(.title2).foregroundColor(.black)){
                    ForEach(payment.payers.indices){
                        ParticipantRow(name: payment.participates[$0], amount: Double(payment.expense)/Double(payment.payers.count))
                    }
                }
                .listRowInsets(EdgeInsets())
                
                Section(header: Text("Notes: ").bold().font(.title2).foregroundColor(.black)){
                    Text(payment.note.texts[0])
                }
                .listRowInsets(EdgeInsets())
            }
            .padding(.horizontal, -15.0)
            
            Button("Delete🗑") {
                //TODO: delte this payment
            }
            .buttonStyle(GrowingButton(backGroundColor: .red, foreGroundColor: .white))
        }
    }
}

struct PaymentDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        PaymentDetailsView(payment: PaymentsDetail())
    }
}
