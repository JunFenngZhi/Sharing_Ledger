//
//  PaymentDetails.swift
//  SharingLedger
//
//  Created by Loaner on 3/29/23.
//

import SwiftUI

struct PaymentDetailsView: View {
    let payment: PaymentsDetail
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var storageModel: StorageModel
    
    @State var showEdit = false
    
    var body: some View {
        VStack{
            VStack(alignment: .leading){
                HStack{
                    SmallCircleImage(image: Image(payment.category.rawValue), width: 50, height: 50, shadowRadius: 7)
                    Text(payment.paymentName).font(.headline)
                    Spacer()
                    Button("Edit✏️") {
                        //TODO: pop out the view to edit payment.
                        showEdit.toggle()
                    }
                    .buttonStyle(GrowingButton(backGroundColor: themeColor, foreGroundColor: .white))
                }
                .padding()
                
                HStack{
                    Text("$" + String(format:"%.2f", payment.expense))
                        .font(.title)
                        .bold()
                    Spacer()
                    Text(payment.time, formatter: DateFormatter.dateTime)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }.padding(.horizontal)
            }
            
            Spacer()
            Rectangle().fill(Color(UIColor.systemGroupedBackground))
                .frame(height: 16)

            List(){
                Section(header: Text("Participants: ").font(.subheadline).foregroundColor(.cyan).bold()){
                    ForEach(payment.participates.indices){
                        ParticipantRow(personID: payment.participates[$0], amount: Double(payment.expense)/Double(payment.participates.count))
                    }
                }
                .listRowInsets(EdgeInsets())
                
                Section(header: Text("Payers: ").font(.subheadline).foregroundColor(.cyan).bold()){
                    ForEach(payment.payers.indices){
                        PayerRow(personID: payment.payers[$0])
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
                self.presentationMode.wrappedValue.dismiss()  // jump bakc to previous view
            }
            .buttonStyle(GrowingButton(backGroundColor: .red, foreGroundColor: .white))
        }
    }
}

struct PaymentDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        PaymentDetailsView(payment: PaymentsDetail(paymentName: "chick-fil-a", expense: 23.45, category: .Restaurant, participates: ["Junfeng Zhi_ID", "Dingzhou Wang_ID", "Suchuan Xing_ID"], payers: ["Junfeng Zhi_ID"], note: "lunch", time: Date.now)).environmentObject(StorageModel())
    }
}
