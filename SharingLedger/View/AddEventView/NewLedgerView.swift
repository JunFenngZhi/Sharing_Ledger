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
                        let newname = peopleOption[selection].firstname+" "+peopleOption[selection].lastname
                        if addedPeopleList.contains(newname) {
                            isPeopleRepeatedAlertPresented = true
                            return
                        }
                        addedPeopleList.append(newname)
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
                        ForEach(0..<peopleOption.count) { index in
                            HStack{
                                SmallRoundImage(image: Image(uiImage: imageFromString(storageModel.personInfo[peopleOption[index].firstname+" "+peopleOption[index].lastname+"_ID"]!.picture)), width: 28, height: 28, shadowRadius: 0)
                                Text(peopleOption[index].firstname+" "+peopleOption[index].lastname)
                            }
                        }
                    }
                    .pickerStyle(.wheel)
                    .frame(height: 150)
                    .onChange(of: selection) { value in
                        print("Invite member: \(peopleOption[value])")
                        // perform any action here
                    }
                }
                
                ForEach(addedPeopleList, id: \.self){ addedPeopleName in
                    
                    HStack{
                        SmallRoundImage(image: Image(uiImage: imageFromString(storageModel.personInfo[addedPeopleName+"_ID"]!.picture)), width: 28, height: 28, shadowRadius: 0)
                        Text(addedPeopleName)
                        Spacer()
                    }
                    .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                        Button(role: .destructive) {
                            if let index = addedPeopleList.firstIndex(of: addedPeopleName) {
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
                if storageModel.allEvents.keys.contains(eventName) {
                    isEventNameExistAlertPresented = true
                    return
                }
                
                let newEvent: EventInfo = EventInfo(eventName: eventName, participates: addedPeopleList)
                storageModel.allEvents[eventName] = newEvent
                for name in addedPeopleList {
                    storageModel.personInfo[name+"_ID"]!.joinedEventNames.append(eventName)
                }
                isNewLedgerShown = false
                //TODO: add database function
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
        NewLedgerView(isNewLedgerShown: .constant(true))
    }
}
