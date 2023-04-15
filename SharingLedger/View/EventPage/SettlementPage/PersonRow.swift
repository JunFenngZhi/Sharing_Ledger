//
//  PersonRow.swift
//  SharingLedger
//
//  Created by Loaner on 4/10/23.
//

import SwiftUI

struct PersonRow: View {
    let picture: Image
    let name: String
    let payAmount: Double
    let index: Int
    
    @Binding var selectedRow: Int?
    
    var body: some View {
        HStack {
            SmallRoundImage(image: picture, width: 30, height: 30, shadowRadius: 3)
            Text(name).font(.headline)
            Image(systemName: selectedRow == index ? "chevron.up" : "chevron.down")
            Spacer()
            Text(payAmount > 0 ? "pay: $" + String(format:"%.2f", payAmount) : "get:$ " + String(format:"%.2f", abs(payAmount)))
                .font(.subheadline)
                .foregroundColor(payAmount > 0 && isZero_Double(num: abs(payAmount)) == false ? .red: .green)
        }
    }
}

struct PersonRow_Previews: PreviewProvider {
    @State static var selectedRow: Int? = 1
    static var previews: some View {
        PersonRow(picture: Image("Unknown"), name: "Junfeng Zhi", payAmount: -123.45, index: 1, selectedRow: $selectedRow)
    }
}
