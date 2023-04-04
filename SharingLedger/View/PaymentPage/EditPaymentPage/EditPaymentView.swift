//
//  EditPaymentView.swift
//  SharingLedger
//
//  Created by Loaner on 4/3/23.
//

import SwiftUI

struct EditPaymentView: View {
    private let categoryList = [
        Category.Restaurant, Category.Shopping, Category.Tickets, Category.Hotel, Category.Traffic
    ]

    @State private var selectedCategory = 0
    @State private var expenseName = ""
    @State private var expenseAmount = ""
    @State private var notes = ""
    @State private var date = Date.now
    
    
    @Binding var showEditPaymentView: Bool

    
    var body: some View {
        VStack(){
            VStack(alignment: .leading){
                Text("Category").font(.title2)
                CategoryPicker(categoryList:categoryList, selectedCategoryIndex: $selectedCategory)
            }
            
            Rectangle().fill(Color(UIColor.systemGroupedBackground))
                .frame(height: 16)
        
            Form{
                Section(header:Text("Payment name")){
                    TextField("Enter name", text: $expenseName)
                }.listRowInsets(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 0))

                Section(header: Text("amaount")){
                    ExpenseAmountInput(expenseAmount: $expenseAmount)
                }.listRowInsets(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 0))
                
                Section(header:Text("Time")){
                    DatePicker(selection: $date, in: ...Date.now, displayedComponents: .date) {
                        Text("Select a date").foregroundColor(.blue)
                    }
                }.listRowInsets(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 0))
                
                Section(header:Text("payer")){
                    Button("select payer") {
                        print("Button pressed!")
                    }
                    Text("  ")
                }.listRowInsets(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 0))
                
                Section(header:Text("participant")){
                    Button("select participant") {
                        print("Button pressed!")
                    }
                    Text("  ")
                }.listRowInsets(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 0))
                
                Section(header: Text("notes")){
                    TextField("", text: $notes)
                }.listRowInsets(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 0))
            }
            .padding(.horizontal, -8.0)
            .padding(.top, -10)
            
            
            HStack{
                Spacer()
                Button("Back") {
                    showEditPaymentView.toggle()
                }
                Spacer()
                Button("Conform") {
                    print("Button pressed!")
                }
                
                Spacer()
                Button("Clear") {
                    print("Button pressed!")
                }
                
                Spacer()
            }
            .padding([.leading,.trailing])
        }
    }
}

struct EditPaymentView_Previews: PreviewProvider {
    static var previews: some View {
        EditPaymentView(showEditPaymentView: .constant(true))
    }
}
