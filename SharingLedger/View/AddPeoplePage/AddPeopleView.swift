//
//  AddPeopleView.swift
//  SharingLedger
//
//  Created by mac on 2023/4/14.
//

import SwiftUI

struct AddPeopleView: View {
    @EnvironmentObject var storageModel: StorageModel
    var eventID: String
    @State private var selection = 0
    @State private var addedPeopleList: [String] = []//contains the person id
    @Binding var isNewLedgerShown: Bool
    @State var isAlertPresented: Bool = false // at least one person Alert
    //@State var isEventNameEmptyAlertPresented: Bool = false
    //@State var isEventNameExistAlertPresented: Bool = false
    @State var isPeopleRepeatedAlertPresented: Bool = false
    @State var isPeopleInPaymentAlertPresented: Bool = false
    var peopleOption: [PersonDetail] {
        var res: [PersonDetail] = []
        for person in storageModel.personInfo.values {
            res.append(person)
        }
        return res
    }
    
    
    var body: some View {
        NavigationView {
            Form{
                //Text(storageModel.allEvents[eventID]!.eventname)
                
                VStack {
                    Text("Selected option: \(peopleOption[selection].fullname)")
                    
                    Button(action: {
                                // Add your action here
                        let newPersonID = peopleOption[selection].id
                        if addedPeopleList.contains(newPersonID) {
                            isPeopleRepeatedAlertPresented = true
                            return
                        }
                        addedPeopleList.append(newPersonID)
                            }) {
                                Text("add")
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                    .padding()
                            }
                            .frame(width: 200, height: 30)
                            .background(Color.blue)
                            .cornerRadius(10)
                            
                    Picker("", selection: $selection) {
                        ForEach(0..<21) { index in
                            HStack{
                                SmallRoundImage(image: Image(uiImage: imageFromString(storageModel.personInfo[peopleOption[index].id]!.picture)), width: 28, height: 28, shadowRadius: 0)
                                Text(peopleOption[index].fullname)
                            }
                        }
                    }
                    .pickerStyle(.wheel)
                    .frame(height: 150)
                    .onChange(of: selection) { value in
                        //print("Invite member: \(peopleOption[value])")
                        // perform any action here
                    }
                }
                
                ForEach(addedPeopleList, id: \.self){ addedPeopleID in
                    
                    HStack{
                        SmallRoundImage(image: Image(uiImage: imageFromString(storageModel.personInfo[addedPeopleID]!.picture)), width: 28, height: 28, shadowRadius: 0)
                        Text(storageModel.personInfo[addedPeopleID]!.fullname)
                        Spacer()
                    }
                    .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                        Button(role: .destructive) {
                            for paymentID in storageModel.allEvents[eventID]!.payments {
                                if storageModel.allPayments[paymentID]!.participates.contains(addedPeopleID) || storageModel.allPayments[paymentID]!.payers.contains(addedPeopleID) {
                                    isPeopleInPaymentAlertPresented = true
                                    return
                                }
                            }
                            
                            if let index = addedPeopleList.firstIndex(of: addedPeopleID) {
                                addedPeopleList.remove(at: index)
                            }
                        } label: {
                            Label("Delete", systemImage: "trash")
                        }
                        .tint(.red)
                    }
                    
                }
            }
            .foregroundColor(.black)
            .multilineTextAlignment(.leading)
            .navigationTitle(storageModel.allEvents[eventID]!.eventname)
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(leading: Button {
                isNewLedgerShown = false
            } label: {
                Label("Cancel", systemImage: "chevron.left")
                    .labelStyle(.titleOnly)
            }
            )
            .navigationBarItems(trailing: Button {
                if addedPeopleList.count == 0 {
                    isAlertPresented = true
                    return
                }
                
                let updatedEvent: EventInfo = EventInfo(id: eventID, eventName: storageModel.allEvents[eventID]!.eventname, payments: storageModel.allEvents[eventID]!.payments, participates: addedPeopleList, createdTime: storageModel.allEvents[eventID]!.createdTime)
                
                storageModel.updateEventParticipants_FireStore(updateEvent: updatedEvent, oldParticipants: storageModel.allEvents[eventID]!.participates, newParticipants: addedPeopleList)
                
                
                isNewLedgerShown = false
                
            } label: {
                Label("Save", systemImage: "chevron.left")
                    .labelStyle(.titleOnly)
            }
                .alert("Event must contain at least one person", isPresented: $isAlertPresented) {
                Button("OK") {
                    isAlertPresented = false
                }
                    
                }
                .alert("This person has already been added", isPresented: $isPeopleRepeatedAlertPresented) {
                Button("OK") {
                    isPeopleRepeatedAlertPresented = false
                }
                    
                }
                .alert("This person is in one of payments, so he can not be removed", isPresented: $isPeopleInPaymentAlertPresented) {
                Button("OK") {
                    isPeopleInPaymentAlertPresented = false
                }
                    
                }
            )
            
            
            
        }
        .onAppear{
            self.addedPeopleList = storageModel.allEvents[eventID]!.participates
        }
    }
}

struct AddPeopleView_Previews: PreviewProvider {
    static var previews: some View {
        AddPeopleView(eventID: "Development_ID",isNewLedgerShown: .constant(true))
    }
}
