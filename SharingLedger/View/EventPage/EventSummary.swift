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
            VStack{
                Text("$" + String(format:"%.2f",totalExpense))
                    .font(.title)
                    .bold()
                Text("Total Expenses").padding(.horizontal)
            }
            Spacer()
            Button(action: {
                print("click settle")
                // TODO: settle the event
            }, label: {
                Text("Settle >")
                    .foregroundColor(.black)
                    .bold()
            })
            .padding()
        }
        .frame(height: 100)
        .background(Color(red: 0.436, green: 0.705, blue: 0.791))
    }
}

struct EventSummary_Previews: PreviewProvider {
    static var previews: some View {
        EventSummary(totalExpense: 1234.56)
    }
}
