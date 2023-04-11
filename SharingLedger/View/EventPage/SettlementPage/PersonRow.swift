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
    let amount: Double
    let index: Int
    
    @Binding var selectedRow: Int?
    
    var body: some View {
        HStack {
            SmallCircleImage(image: Image("Unknown"), width: 30, height: 30, shadowRadius: 3)
            Text(name).font(.headline)
            Image(systemName: selectedRow == index ? "chevron.up" : "chevron.down")
            Spacer()
            Text(amount > 0 ? "get: $" + String(format:"%.2f", amount) : "pay:$ " + String(format:"%.2f", amount) )
                .font(.subheadline)
                .foregroundColor(amount >= 0 ? .green: .red)
        }
    }
}

struct PersonRow_Previews: PreviewProvider {
    @State static var selectedRow: Int? = 1
    static var previews: some View {
        PersonRow(picture: Image("Unknown"), name: "Junfeng Zhi", amount: 123.45, index: 1, selectedRow: $selectedRow)
    }
}
