//
//  AddEventRow.swift
//  SharingLedger
//
//  Created by mac on 2023/4/12.
//

import SwiftUI

struct AddEventRow: View {
    var body: some View {
        ZStack{
            Rectangle()
                .fill(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
                .frame(width: 332, height: 60)
                .shadow(color: Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.25)), radius:4, x:0, y:4)
            HStack(spacing: 10){
                PlusButton()
                
                Text("New Ledger")
                    .lineLimit(2)
                    .font(.custom("Inter", size: 18))
                    .fontWeight(.bold)
            }
        }
    }
}

struct AddEventRow_Previews: PreviewProvider {
    static var previews: some View {
        AddEventRow()
    }
}
