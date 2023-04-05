//
//  PayerRow.swift
//  SharingLedger
//
//  Created by Loaner on 3/30/23.
//

import SwiftUI

struct PayerRow: View {
    let name: String
    var body: some View {
        HStack{
            SmallCircleImage(image: Image("Unknown"), width: 50, height: 50, shadowRadius: 7) //TODO: update image
            Text(name)
                .font(.headline)
                .padding()
        }
        .padding()
    }
}

struct PayerRow_Previews: PreviewProvider {
    static var previews: some View {
        PayerRow(name:"Junfeng")
    }
}
