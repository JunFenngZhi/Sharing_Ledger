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
            SmallCircleImage(image: Image("Unknown"), width: 50, height: 50) //TODO: update image based on category
            VStack(alignment: .leading){
                Text(payment.paymentName)
                    .font(.headline)
                    .bold()
                Text(payment.payers[0] + "... pay, \(payment.participates.count) people participate")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            Spacer()
            Text("$123.45")
                .font(.title2)
                .bold()
        }
        .padding()
    }
}

struct PaymentRow_Previews: PreviewProvider {
    static var previews: some View {
        PaymentRow(payment: PaymentsDetail())
    }
}
