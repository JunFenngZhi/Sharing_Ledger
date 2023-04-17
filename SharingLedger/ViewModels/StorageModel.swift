//
//  StorageModel.swift
//  SharingLedger
//
//  Created by mac on 2023/3/28.
//

import Foundation
import FirebaseCore
import FirebaseFirestore

class StorageModel: ObservableObject {
    @Published var personInfo: [String: PersonDetail] = [:] // PersonDetail.id : PersonDetail
    @Published var allEvents: [String: EventInfo] = [:] // EventInfo.id : EventInfo
    @Published var allPayments: [String: PaymentsDetail] = [:] // PaymentsDetail.id : PaymentsDetail
    
    init(){
        //initForPreViewTest()
    }
    
    func initForPreViewTest(){
        var newevent = EventInfo(eventName: "Development", participates: ["Junfeng Zhi_ID", "Dingzhou Wang_ID", "Suchuan Xing_ID"])
        newevent.id = "Development_ID"
        self.allEvents["Development_ID"] = newevent
        
        let payments_1 = PaymentsDetail(paymentName: "chick-fil-a", expense: 20, category: .Restaurant, participates: ["Junfeng Zhi_ID", "Dingzhou Wang_ID", "Suchuan Xing_ID"], payers: ["Junfeng Zhi_ID"], note: "lunch", time: Date.now)
        let payments_2 = PaymentsDetail(paymentName: "nuro taco", expense: 40, category: .Restaurant, participates: ["Junfeng Zhi_ID", "Dingzhou Wang_ID", "Suchuan Xing_ID"], payers: ["Suchuan Xing_ID"], note: "dinner", time: Date.now.addingTimeInterval(-1*60*60*24))
        self.allPayments["payments_1_ID"] = payments_1
        self.allPayments["payments_2_ID"] = payments_2
        self.allEvents["Development_ID"]?.payments.append("payments_1_ID")
        self.allEvents["Development_ID"]?.payments.append("payments_2_ID")
    
        let suchuan_pic: String = personInfo["Suchuan Xing_ID"]?.picture ?? "No pic"
        let dingzhou_pic: String = personInfo["Dingzhou Wang_ID"]?.picture ?? "No pic"
        let junfeng_pic: String = personInfo["Junfeng Zhi_ID"]?.picture ?? "No pic"
    
        personInfo["Suchuan Xing_ID"] = PersonDetail(id: "Suchuan Xing_ID", lname: "Xing", fname: "Suchuan", joinedEventNames: ["Development_ID"])
        personInfo["Dingzhou Wang_ID"] = PersonDetail(id: "Dingzhou Wang_ID", lname: "Wang", fname: "Dingzhou", joinedEventNames: ["Development_ID"])
        personInfo["Junfeng Zhi_ID"] = PersonDetail(id: "Junfeng Zhi_ID", lname: "Zhi", fname: "Junfeng", joinedEventNames: ["Development_ID"])
        
        personInfo["Suchuan Xing_ID"]!.picture = suchuan_pic
        personInfo["Dingzhou Wang_ID"]!.picture = dingzhou_pic
        personInfo["Junfeng Zhi_ID"]!.picture = junfeng_pic
}
    
    func initFromFireStoreDatabase(){
        getPersonDetail_Firestore()
        getEventInfo_Firestore()
        getPaymentsDetail_Firestore()
    }
    
    //TODO: move these get function to fireStoreManager
    /// load all the data of PersonDetail column from database and save it to personInfo
    func getPersonDetail_Firestore(){
        let db = Firestore.firestore()
        db.collection("PersonDetail").getDocuments { snapshot, error in
            if error == nil{
                if let snapshot = snapshot{
                    _ = snapshot.documents.map { d in
                        let person = PersonDetail(  // create item of PersonDetail
                            id: d.documentID,
                            lname: d["lastname"] as? String ?? "",
                            fname: d["firstname"] as? String ?? "",
                            joinedEventNames: d["joinedEventNames"] as? [String] ?? [""],
                            picture: d["picture"] as? String ?? ""
                        )
                        self.personInfo[person.id] = person
                        return person
                    }
                    print("✅ Get all the documents in PersonDetail column")
                }
            }else{
                print("❗️ Error[getPersonDetail_Firestore]: " + error.debugDescription)
            }
            
        }
    }
    
    /// load all the data of EventInfo column from database and save it to allEvents
    func getEventInfo_Firestore(){
        let db = Firestore.firestore()
        db.collection("EventInfo").getDocuments { snapshot, error in
            if error == nil{
                if let snapshot = snapshot{
                    _ = snapshot.documents.map { d in
                        let eventInfo = EventInfo(
                            id: d.documentID,
                            eventName: d["eventname"] as! String,
                            payments: d["payments"] as! [String],
                            participates: d["participates"] as! [String]
                        )
                        self.allEvents[eventInfo.id] = eventInfo
                        return eventInfo
                    }
                    print("✅ Get all the documents in EventInfo column")
                }
            }else{
                print("❗️ Error[getEventInfo_Firestore]: " + error.debugDescription)
            }
            
        }
    }
    
    /// load all the data of PaymentsDetail column from database and save it to allPayments
    func getPaymentsDetail_Firestore(){
        let db = Firestore.firestore()
        db.collection("PaymentsDetail").getDocuments { snapshot, error in
            if error == nil{
                if let snapshot = snapshot{
                    _ = snapshot.documents.map { d in
                        let payments = PaymentsDetail( // create item of PersonDetail
                            id: d.documentID,
                            paymentName: d["paymentName"] as! String,
                            expense: d["expense"] as! Double,
                            category: Category(rawValue: d["category"] as! String) ?? .Default,
                            participates: d["participates"] as! [String],
                            payers: d["payers"] as! [String],
                            note: d["note"] as! String,
                            time: (d["time"] as? Timestamp)?.dateValue() ?? Date()
                        )
                        self.allPayments[payments.id] = payments
                        return payments
                    }
                    print("✅ Get all the documents in PaymentsDetail column")
                }
            }else{
                print("❗️ Error[getPaymentsDetail_Firestore]: " + error.debugDescription)
            }
        }
    }

    /// add a new event to EventInfo column and allEvents dict.
    /// Update personInfo dict and PersonDetails column to add joinEvent.
    func addNewEvent_FireStore(newEvent: EventInfo){
        let db = Firestore.firestore()
        var documentReference: DocumentReference? = nil
        documentReference = db.collection("EventInfo").addDocument(data: ["eventname":newEvent.eventname, "payments":newEvent.payments, "participates": newEvent.participates]) { error in
            if error != nil{
                print("❗️ Error[addNewEvent_FireStore]: Fail to add \(newEvent.eventname). Details:" + error.debugDescription)
            } else {
                let documentID = documentReference?.documentID
                print("✅ EventInfo \(newEvent.eventname) is added successfully with ID: \(documentID ?? "")")
                newEvent.id = documentID ?? "" // update local eventInfo, fill id.
                db.collection("EventInfo").document(documentID!).updateData(["id": newEvent.id])  // update firestore document, fill id.
                
                self.allEvents[newEvent.id] = newEvent // add to local cache
                
                // update eventInfo to add newPayment's id.
                for personId in newEvent.participates {
                    self.personInfo[personId]!.joinedEventNames.append(newEvent.id)
                    let personInfo = self.personInfo[personId]!
                    FireStoreManager().updatePersonDetail(toUpdate: personInfo)
                }
            }
        }
    }
    
    /// update given event in local cache and EventInfo column.
    /// update personInfo to change their connection with given event.
    func updateEventParticipants_FireStore(updateEvent: EventInfo, oldParticipants: [String], newParticipants: [String]){
        let firestoreMgr = FireStoreManager()
        
        self.allEvents[updateEvent.id] = updateEvent
        firestoreMgr.updateEventInfo(toUpdate: updateEvent)
        
        // delete removed participants
        for oldPersonID in oldParticipants{
            if(newParticipants.contains(oldPersonID) == false){
                self.personInfo[oldPersonID]?.joinedEventNames.removeAll(where: { joinedEventID in
                    return joinedEventID == updateEvent.id
                })
                firestoreMgr.updatePersonDetail(toUpdate: self.personInfo[oldPersonID]!)
            }
        }
        
        // add new participants
        for newPersonID in newParticipants{
            if(oldParticipants.contains(newPersonID) == false){
                self.personInfo[newPersonID]!.joinedEventNames.append(updateEvent.id)
                firestoreMgr.updatePersonDetail(toUpdate: self.personInfo[newPersonID]!)
            }
        }
    }
    
    
    
    
    private func buildPersonDetailFromDukePerson(dukePerson: DukePerson) -> PersonDetail{
        let id: String = dukePerson.firstname + " " + dukePerson.lastname + "_ID"
        let lname: String = dukePerson.lastname
        let fname: String = dukePerson.firstname
        let personDetail: PersonDetail = PersonDetail(id: id, lname: lname, fname: fname, joinedEventNames: [])
        personDetail.picture = dukePerson.picture
        return personDetail
    }
    
    func initFromDukeStorageModel(dukeStorageModel: DukeStorageModel){
        let viewModel = ViewModel()
        for netid in dukeStorageModel.personDict.keys {
            let dukePerson: DukePerson = dukeStorageModel.personDict[netid]!
            let personDetail: PersonDetail = buildPersonDetailFromDukePerson(dukePerson: dukePerson)
            personInfo[personDetail.firstname + " " + personDetail.lastname + "_ID"] = personDetail
            
            DispatchQueue.global(qos: .background).async {
                viewModel.add_PersonDetail(toAdd: personDetail) { documentID, error in
                    guard let personID = documentID, error == nil else {
                        print("Error adding PersonDetail document: \(error!)")
                        return
                    }
                    
                    if(viewModel.personInfo.isEmpty){
                        throw SyncError.DownloadFailure(msg: "Fail to download data from database.")
                    }
                    self.personInfo = viewModel.personInfo
                    
                    
                }
                
            }
            
        }
    }
    
    func addNewEvent(newEvent: EventInfo) throws {
        let viewModel = ViewModel()
        
        DispatchQueue.global(qos: .background).async {
            viewModel.add_EventInfo(toAdd: newEvent) { documentID, error in
                guard let eventID = documentID, error == nil else {
                    print("Error adding EventInfo document: \(error!)")
                    return
                }
                // sync storage model with database
                if(viewModel.allEvents.isEmpty){
                    throw SyncError.DownloadFailure(msg: "Fail to download data from database.")
                }
                self.allEvents = viewModel.allEvents
                
                // update eventInfo to add newPayment's id.
                for pid in self.allEvents[eventID]!.participates {
                    
                    self.personInfo[pid]!.joinedEventNames.append(eventID)
                    let newPersonDetail: PersonDetail = self.personInfo[pid]!
                    viewModel.update_PersonDetail(toUpdate: newPersonDetail)
                }
                
            }
        }
        
    }
    
    func updateEvent(newEvent: EventInfo, oldEvent: EventInfo) throws {
        let viewModel = ViewModel()
        DispatchQueue.global(qos: .background).async {
            viewModel.update_EventInfo(toUpdate: newEvent)
            
            self.allEvents[oldEvent.id] = newEvent
            
            //participates who are in old event should delete the eventID in their joinedEvent, new event add the participates
            for personID in oldEvent.participates {
                if let index = self.personInfo[personID]!.joinedEventNames.firstIndex(of: oldEvent.id) {
                    self.personInfo[personID]!.joinedEventNames.remove(at: index)
                    viewModel.update_PersonDetail(toUpdate: self.personInfo[personID]!)
                }
            }
            
            for personID in newEvent.participates {
                self.personInfo[personID]!.joinedEventNames.append(newEvent.id)
                viewModel.update_PersonDetail(toUpdate: self.personInfo[personID]!)
            }
            
            
        }
    }
    
    /// Add new Payments to specific events. Sync the changes with backend database.
    func addNewPayments(newPayment: PaymentsDetail, eventID: String) throws {
        let viewModel = ViewModel()
        DispatchQueue.global(qos: .background).async {
            viewModel.add_PaymentsDetail(toAdd: newPayment) { documentID, error in
                guard let paymentID = documentID, error == nil else {
                    print("Error adding PaymentsDetail document: \(error!)")
                    return
                }
                // sync storage model with database
                if(viewModel.allPayments.isEmpty){
                    throw SyncError.DownloadFailure(msg: "Fail to download data from database.")
                }
                self.allPayments = viewModel.allPayments
                
                // update eventInfo to add newPayment's id.
                self.allEvents[eventID]?.payments.append(paymentID)
                viewModel.update_EventInfo(toUpdate: self.allEvents[eventID]!)
            }
        }
    }
    
    /// Delete specific event. Sync the changes with backend database
    func deletePayments(payment: PaymentsDetail, eventID: String){
        let viewModel = ViewModel()
        viewModel.delete_PaymentsDetail(toDelete: payment)
        
        // update eventInfo to remove Payment's id.
        self.allEvents[eventID]?.payments.removeAll(where: { id in
            return id == payment.id
        })
        
        viewModel.update_EventInfo(toUpdate: self.allEvents[eventID]!)
    }
    
    
    
}
