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
    
    @Binding var showEditPaymentView: Bool
    
    @State var selectedCategory = 0
    @State var name = ""
    @State var amount = ""
    @State var notes = ""

    
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
                    TextField("Enter name", text: $name)
                }.listRowInsets(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 0))

                Section(header: Text("amaount")){
                    TextField("$0.00", text: $amount)
                    //TODO: date picker
                }.listRowInsets(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 0))
                
                Section(header:Text("Time")){
                    Button("select time") {
                        print("Button pressed!")
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
                    //TextField("", text: $notes)
                    Text("\(selectedCategory)")
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
