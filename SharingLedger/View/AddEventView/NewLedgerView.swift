//
//  NewLedgerView.swift
//  SharingLedger
//
//  Created by mac on 2023/4/13.
//

import SwiftUI

struct NewLedgerView: View {
    @EnvironmentObject var storageModel: StorageModel
    @State var eventName: String = ""
    @State private var selection = 0
    @State private var addedPeopleList: [String] = []
    @Binding var isNewLedgerShown: Bool
    @State var isAlertPresented: Bool = false
    @State var isEventNameEmptyAlertPresented: Bool = false
    @State var isEventNameExistAlertPresented: Bool = false
    @State var isPeopleRepeatedAlertPresented: Bool = false
    
    var peopleOption: [PersonDetail] {
        var res: [PersonDetail] = []
        for person in storageModel.personInfo.values {
            res.append(person)
        }
//        for pd in res {
//            print(pd.id)
//        }
        return res
        
    }
    
    var body: some View {
        NavigationView {
            Form{
                TextField(text: $eventName, prompt: Text("Input event name:"), label: {() in Text("Input event name:")})
                
                VStack {
                    Text("Selected option: \(peopleOption[selection].firstname+" "+peopleOption[selection].lastname)")
                    
                    Button(action: {
                                // Add your action here
                        let newPeopleID = peopleOption[selection].id
                        if addedPeopleList.contains(newPeopleID) {
                            isPeopleRepeatedAlertPresented = true
                            return
                        }
                        addedPeopleList.append(newPeopleID)
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
            .multilineTextAlignment(.leading)
            .navigationTitle("New Ledger")
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
                if eventName == "" {
                    isEventNameEmptyAlertPresented = true
                    return
                }
                let allevents = storageModel.allEvents.values
                var alleventsName :[String] = []
                for event in allevents {
                    alleventsName.append(event.eventname)
                }
                if alleventsName.contains(eventName) {
                    isEventNameExistAlertPresented = true
                    return
                }
                
                let newEvent: EventInfo = EventInfo(eventName: eventName, participates: addedPeopleList)
                
                storageModel.addNewEvent_FireStore(newEvent: newEvent) // add new event to local cache and firestore database
                
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
                .alert("Event name must not be empty", isPresented: $isEventNameEmptyAlertPresented) {
                Button("OK") {
                    isEventNameEmptyAlertPresented = false
                }
                    
                }
                .alert("Event name already exists", isPresented: $isEventNameExistAlertPresented) {
                Button("OK") {
                    isEventNameExistAlertPresented = false
                }
                    
                }
                .alert("This person has already been added", isPresented: $isPeopleRepeatedAlertPresented) {
                Button("OK") {
                    isPeopleRepeatedAlertPresented = false
                }
                    
                }
            )
            
            
            
        }
    }
}

struct NewLedgerView_Previews: PreviewProvider {
    static var previews: some View {
        NewLedgerView(isNewLedgerShown: .constant(true)).environmentObject(StorageModel())
    }
}
