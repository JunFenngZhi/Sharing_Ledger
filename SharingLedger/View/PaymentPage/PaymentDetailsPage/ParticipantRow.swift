//
//  ParticipantRow.swift
//  SharingLedger
//
//  Created by Loaner on 3/30/23.
//

import SwiftUI

struct ParticipantRow: View {
    let name: String
    let amount: Double
    var body: some View {
        HStack{
            SmallCircleImage(image: Image("Unknown"), width: 50, height: 50) //TODO: update image
            Text(name)
                .font(.headline)
                .padding()
            Spacer()
            Text("$" + String(format:"%.2f", amount))
                .font(.subheadline)
                .foregroundColor(.gray)
        }
        .padding()
    }
}

struct ParticipantRow_Previews: PreviewProvider {
    static var previews: some View {
        ParticipantRow(name: "Junfeng", amount: 123.45)
    }
}
