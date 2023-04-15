//
//  ExpenseRow.swift
//  SharingLedger
//
//  Created by Loaner on 3/29/23.
//

import SwiftUI

struct PaymentRow: View {
    let payment: PaymentsDetail
    var body: some View {
        HStack{
            SmallCircleImage(image: Image(payment.category.rawValue), width: 50, height: 50,shadowRadius: 7)
            VStack(alignment: .leading){
                Text(payment.paymentName)
                    .font(.headline)
                    .bold()
                Text(payment.payers[0] + "... pay, \(payment.participates.count) people participate")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            Spacer()
            Text("$" + String(format:"%.2f",payment.expense))
                .font(.title2)
                .bold()
        }
        .padding()
    }
}

struct PaymentRow_Previews: PreviewProvider {
    static var previews: some View {
        PaymentRow(payment: PaymentsDetail(paymentName: "chick-fil-a", expense: 23.45, category: .Restaurant, participates: ["Junfeng Zhi", "Dingzhou Wang", "Suchuan Xing"], payers: ["Junfeng Zhi"], note: "lunch", time: Date.now))
    }
}
