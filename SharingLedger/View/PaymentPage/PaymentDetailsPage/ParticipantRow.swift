//
//  ParticipantRow.swift
//  SharingLedger
//
//  Created by Loaner on 3/30/23.
//

import SwiftUI

struct ParticipantRow: View {
    @EnvironmentObject var storageModel: StorageModel
    let personID: String
    let amount: Double
    var body: some View {
        let personInfo = storageModel.personInfo[personID]!
        HStack{
            SmallRoundImage(image: Image(uiImage: imageFromString(personInfo.picture)), width: 50, height: 50, shadowRadius: 7) 
            Text(personInfo.firstname + " " + personInfo.lastname)
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
        ParticipantRow(personID: "Junfeng Zhi_ID", amount: 123.45).environmentObject(StorageModel())
    }
}
