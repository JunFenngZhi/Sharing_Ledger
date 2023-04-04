//
//  EventSummary.swift
//  SharingLedger
//
//  Created by Loaner on 3/29/23.
//

import SwiftUI

struct EventSummary: View {
    var totalExpense: Double
    var body: some View {
        HStack{
            VStack(alignment: .leading){
                Text("$" + String(format:"%.2f",totalExpense))
                    .font(.title)
                    .bold()
                    .foregroundColor(.white)
                Text("Total Expenses")
                    .foregroundColor(.white)
            }
            .padding(.horizontal)
            
            Spacer()
            
            Button(action: {
                print("click settle")
                // TODO: settle the event
            }, label: {
                Text("Settle >")
                    .foregroundColor(.white)
                    .bold()
            })
            .padding()
        }
        .frame(height: 100)
        .background(themeColor)
    }
}

struct EventSummary_Previews: PreviewProvider {
    static var previews: some View {
        EventSummary(totalExpense: 1234.56)
    }
}
