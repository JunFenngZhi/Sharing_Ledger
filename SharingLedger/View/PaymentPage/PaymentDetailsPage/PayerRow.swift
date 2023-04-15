//
//  PayerRow.swift
//  SharingLedger
//
//  Created by Loaner on 3/30/23.
//

import SwiftUI

struct PayerRow: View {
    @EnvironmentObject var storageModel: StorageModel
    let personID: String
    var body: some View {
        let personInfo = storageModel.personInfo[personID]!
        HStack{
            SmallRoundImage(image: Image(uiImage: imageFromString(personInfo.picture)), width: 50, height: 50, shadowRadius: 7)
            Text(personInfo.firstname + " " + personInfo.lastname)
                .font(.headline)
                .padding()
        }
        .padding()
    }
}

struct PayerRow_Previews: PreviewProvider {
    static var previews: some View {
        PayerRow(personID:"Junfeng Zhi_ID").environmentObject(StorageModel())
    }
}
