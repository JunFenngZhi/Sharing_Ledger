//
//  ExpenseAmountInput.swift
//  SharingLedger
//
//  Created by Loaner on 4/4/23.
//

import SwiftUI

struct ExpenseAmountInput: View {
    @State private var amountInputValid = true
    @Binding var expenseAmount: String
    
    var body: some View {
        HStack{
            Text("$")
            TextField("0.00", text: $expenseAmount)
                .onChange(of: expenseAmount) { newValue in
                    let formatter = NumberFormatter()
                    formatter.locale = Locale.current
                    formatter.numberStyle = .decimal
                    
                    if let number = formatter.number(from: newValue), number.doubleValue > 0 {
                       amountInputValid = true
                   } else {
                       amountInputValid = false
                   }
                }
                .border(amountInputValid == true ? Color.white : Color.red, width: 2)
                .textFieldStyle(.roundedBorder)
        }
    }
}

struct ExpenseAmountInput_Previews: PreviewProvider {
    @State static var expenseAmount: String = "-1233"
    static var previews: some View {
        ExpenseAmountInput(expenseAmount: $expenseAmount)
    }
}
