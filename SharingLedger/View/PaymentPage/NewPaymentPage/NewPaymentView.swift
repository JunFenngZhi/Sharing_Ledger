//
//  EditPaymentView.swift
//  SharingLedger
//
//  Created by Loaner on 4/3/23.
//

import SwiftUI

struct NewPaymentView: View {
    let eventID: String
    
    private let categoryList = [
        Category.Restaurant, Category.Shopping, Category.Tickets, Category.Hotel, Category.Traffic
    ]

    @State private var selectedCategory = 0
    @State private var expenseName = ""
    @State private var expenseAmount = ""
    @State private var notes = ""
    @State private var date = Date.now
    @State private var selectedPayer: Set<String> = []
    @State private var selectedParticipant: Set<String> = []
    
    @EnvironmentObject var storageModel: StorageModel
    
    @State var showSelectPayerView: Bool = false
    @State var showSelectParticipantView: Bool = false
    @State var showAlert: Bool = false
    @State var alertMessage: String = "Successfully add new payment. Click back to return."
    
    @Binding var viewType: ViewType

    var body: some View {
        let event: EventInfo = storageModel.allEvents[eventID]!
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
                }
                .listRowInsets(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 0))

                Section(header: Text("amaount")){
                    ExpenseAmountInput(expenseAmount: $expenseAmount)
                }
                .listRowInsets(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 0))
                
                Section(header:Text("Time")){
                    DatePicker(selection: $date, in: ...Date.now, displayedComponents: .date) {
                        Text("Select a date").foregroundColor(.blue)
                    }
                }
                .listRowInsets(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 0))
                
                Section(header:Text("payer")){
                    Button("select payer") {
                        showSelectPayerView.toggle()
                    }
                    if(selectedPayer.isEmpty){
                        Text("null").foregroundColor(.gray).font(.subheadline)
                    }
                    else{
                        HStack(spacing: 10){
                            ForEach(selectedPayer.sorted(), id: \.self){id in
                                let personInfo = storageModel.personInfo[id]!
                                SmallRoundImage(image: Image(uiImage: imageFromString(personInfo.picture)), width: 40, height: 40, shadowRadius: 2)
                            }
                        }
                        .padding(.vertical)
                    }
                }
                .listRowInsets(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 0))
                .sheet(isPresented: $showSelectPayerView){
                    SelectPayerView(participants: event.participates, selectedPayer: $selectedPayer, showSelectPayerView: $showSelectPayerView)
                }

                Section(header:Text("participant")){
                    Button("select participant") {
                        showSelectParticipantView.toggle()
                    }
                    if(selectedParticipant.isEmpty){
                        Text("null").foregroundColor(.gray).font(.subheadline)
                    }
                    else{
                        SelectedParticipantList(selectedParticipant: selectedParticipant).padding([.vertical,.trailing])
                    }
                }
                .listRowInsets(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 0))
                .sheet(isPresented: $showSelectParticipantView){
                    SelectParticipantView(participants: event.participates, selectedParticipants: $selectedParticipant, showSelectParticipantsView: $showSelectParticipantView)
                }
                
                Section(header: Text("notes")){
                    TextField("Enter notes", text: $notes)
                }
                .listRowInsets(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 0))
            }
            .padding(.horizontal, -8.0)
            .padding(.top, -10)
            
            HStack{
                Spacer()
                
                Button("  Back  ") {
                    viewType = .EventDetailsView
                }
                .buttonStyle(GrowingButton(backGroundColor: themeColor, foreGroundColor: .white))
                .frame(maxWidth: .infinity, maxHeight: 50)
                
                Spacer()
                
                Button(" Confirm ") {
                    do{
                        showAlert.toggle()
                        let newPayment = try newPaymentViewInputHandle(expenseName: expenseName, expenseAmount: expenseAmount, category: categoryList[selectedCategory], notes: notes, date: date, selectedPayer: selectedPayer, selectedParticipant: selectedParticipant)
                        storageModel.addNewPayment_FireStore(newPayment: newPayment, eventID: eventID)
                    } catch InputError.invalidArgValue(msg: let reason){
                        alertMessage = reason
                    } catch{
                        alertMessage = error.localizedDescription.debugDescription
                    }
                }
                .alert(isPresented: $showAlert){
                    Alert(title: Text("Message"),message: Text(alertMessage))
                }
                .buttonStyle(GrowingButton(backGroundColor: themeColor, foreGroundColor: .white))
                .frame(maxWidth: .infinity, maxHeight: 50)
                
                Spacer()
                
                Button("  Clear  ") {
                    expenseName = ""
                    expenseAmount = ""
                    notes = ""
                    date = Date.now
                    selectedPayer.removeAll()
                    selectedParticipant.removeAll()
                }
                .buttonStyle(GrowingButton(backGroundColor: themeColor, foreGroundColor: .white))
                .frame(maxWidth: .infinity, maxHeight: 50)
                
                Spacer()
            }
            .padding([.leading,.trailing])
        }
    }
}

struct NewPaymentView_Previews: PreviewProvider {
    @State static var viewType: ViewType = .NewPaymentView
    static var previews: some View {
        NewPaymentView(eventID: "Development_ID", viewType: $viewType).environmentObject(StorageModel())
    }
}
