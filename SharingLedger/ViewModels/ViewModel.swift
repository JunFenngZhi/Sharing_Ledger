//
//  ViewModel.swift
//  SharingLedger
//
//  Created by Dingzhou Wang on 3/29/23.
//

import Foundation
import FirebaseCore
import FirebaseFirestore

class ViewModel: ObservableObject{
    @Published var list = [PersonDetail]()
    
    
    @Published var PersonDetail_list = [PersonDetail]()
    @Published var personInfo: [String: PersonDetail] = [:] // PersonDetail.id : PersonDetail
    @Published var EventInfo_list = [EventInfo]()
    @Published var allEvents: [String: EventInfo] = [:] // EventInfo.id : EventInfo
    @Published var PaymentsDetail_list = [PaymentsDetail]()
    @Published var allPayments: [String: PaymentsDetail] = [:] // PaymentsDetail.id : PaymentsDetail
    @Published var Note_list = [Note]()
    
    func getData(){
        // get ref to the database
        let db = Firestore.firestore()
        
        db.collection("PersonDetail").getDocuments { snapshot, error in
            if error == nil{
                // no errors
                if let snapshot = snapshot{
                    // Update in main thread
                    DispatchQueue.main.async {
                        // get all documents and create todos
                        //for doc in snapshot.documents , we can write like this
                        self.list = snapshot.documents.map { d in
                            // create item of PersonDetail
                            return  PersonDetail(id: d.documentID, lname: d["lastname"] as? String ?? "", fname: d["firstname"] as? String ?? "", joinedEventNames: d["joinedEventNames"] as? [String] ?? [""])
                        }
                    }
                }
            }else{
                // handle
            }
            
        }
        
    }
    
    //    func addData(firstname: String, lastname: String, joinedEventNames: [String]){
    func addData(toAdd: PersonDetail){

        let db = Firestore.firestore()
//        db.collection("PersonDetail").document(toAdd.id).setData(["firstname":toAdd.firstname, "lastname":toAdd.lastname, "joinedEventNames":toAdd.joinedEventNames]){ error in
        db.collection("PersonDetail").addDocument(data: ["firstname":toAdd.firstname, "lastname":toAdd.lastname, "joinedEventNames":toAdd.joinedEventNames]){ error in
            // Check error
            if error == nil{
                // get data to retrieve latest data
                self.getData()
            }
            else{
                
            }
        }
        
//        let p_detail = PaymentsDetail(paymentName: "test_payment1", expense: 1234, category: Category.Restaurant, participates: ["Suchuan Xing", "Dingzhou Wang"], payers: ["Suchuan Xing"], note: "test_note", time: Date())
//
//        let dict: [String: PaymentsDetail] = ["test_payment_name": p_detail]
//        db.collection("EventInfo").addDocument(data: ["conclusion":100, "eventname":"test_event_name", "participates":["Suchuan Xing", "Dingzhou Wang"], "payments": dict]){ error in
//            // Check error
//            if error == nil{
//                // get data to retrieve latest data
//                self.getData()
//            }
//            else{
//                print(error!)
//            }
//        }
    }
    
    func deleteData(toDelete: PersonDetail){
        let db = Firestore.firestore()
        
        db.collection("PersonDetail").document(toDelete.id).delete{ error in
            if error == nil{
                
                DispatchQueue.main.async {
                    self.list.removeAll{ persondetail in
                        return persondetail.id == toDelete.id
                        
                    }
                }
                
            }
        }
        
    }
    
    func updateData(toUpdate: PersonDetail){
        let db = Firestore.firestore()

        // merge: true -> only update specific, and keep other unchange part
        db.collection("PersonDetail").document(toUpdate.id).setData(["joinedEventNames": "new_event"], merge: true){ error in
            if error == nil{
                self.getData()
            }
            
        }
    }
    
    public struct City: Codable {

        let name: String
        let state: String?
        let country: String?
        let isCapital: Bool?
        let population: Int64?

        enum CodingKeys: String, CodingKey {
            case name
            case state
            case country
            case isCapital = "capital"
            case population
        }

    }
    
    func updateData_(toUpdate: PersonDetail) {
        let city = City(name: "Los Angeles",
                        state: "CA",
                        country: "USA",
                        isCapital: false,
                        population: 5000000)
//        let note = Note()
        let p_detail = PaymentsDetail(paymentName: "test_payment1", expense: 1234, category: Category.Restaurant, participates: ["Suchuan Xing", "Dingzhou Wang"], payers: ["Suchuan Xing"], note: "test_note", time: Date())

        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(p_detail)
            let dictionary = try JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]

            let db = Firestore.firestore()
            try db.collection("PaymentsDetail").document("ID1").setData(dictionary)
        } catch let error {
            print("Error writing city to Firestore: \(error)")
        }
    }

    // data_base function
    // get
    func get_EventInfo(){
        let db = Firestore.firestore()
        db.collection("EventInfo").getDocuments { snapshot, error in
            if error == nil{
                if let snapshot = snapshot{
                    DispatchQueue.main.async {
                        self.EventInfo_list = snapshot.documents.map { d in
                            let eventInfo = EventInfo(
                                id: d.documentID,
                                eventName: d["eventname"] as! String,
                                payments: d["payments"] as! [String],
                                participates: d["participates"] as! [String]
                            )
                            self.allEvents[eventInfo.id] = eventInfo
                            return eventInfo
                        }
                    }
                }
            }else{
                // handle
                print("error in get_PersonDetail")
                self.EventInfo_list = []
                self.allEvents = [:]
            }
            
        }
    }
    
    func get_Note(){
        let db = Firestore.firestore()
        
        db.collection("Note").getDocuments { snapshot, error in
            if error == nil{
                if let snapshot = snapshot{
                    DispatchQueue.main.async {
                        self.Note_list = snapshot.documents.map { d in
                            return Note(text: d["text"] as! String)
                        }
                    }
                }
            }else{
                // handle
                print("error in get_Note")
                self.Note_list = []
            }
            
        }
    }
    
    func get_PaymentsDetail(){
        // get ref to the database
        let db = Firestore.firestore()
        db.collection("PaymentsDetail").getDocuments { snapshot, error in
            if error == nil{
                // no errors
                if let snapshot = snapshot{
                    // Update in main thread
                    DispatchQueue.main.async {
                        // get all documents and create todos
                        //for doc in snapshot.documents , we can write like this
                        self.PaymentsDetail_list = snapshot.documents.map { d in
                            // create item of PersonDetail
                            let payments = PaymentsDetail(
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
                    }
                }
            }else{
                // handle
                print("error in get_PaymentsDetail")
                self.PaymentsDetail_list = []
                self.allPayments = [:]
            }
            
        }
    }
    
    func get_PersonDetail(){
        // get ref to the database
        let db = Firestore.firestore()
        
        db.collection("PersonDetail").getDocuments { snapshot, error in
            if error == nil{
                // no errors
                if let snapshot = snapshot{
                    // Update in main thread
                    DispatchQueue.main.async {
                        // get all documents and create todos
                        //for doc in snapshot.documents , we can write like this
                        self.PersonDetail_list = snapshot.documents.map { d in
                            // create item of PersonDetail
                            let person = PersonDetail(
                                id: d.documentID,
                                lname: d["lastname"] as? String ?? "",
                                fname: d["firstname"] as? String ?? "",
                                joinedEventNames: d["joinedEventNames"] as? [String] ?? [""]
                            )
                            self.personInfo[person.id] = person
                            return person
                        }
                    }
                }
            }else{
                // handle
                print("error in get_PersonDetail")
                self.list = []
                self.personInfo = [:]
            }
            
        }
    }
    
    
    // add
    func add_EventInfo(toAdd: EventInfo) -> String?{
        let db = Firestore.firestore()
        var documentReference: DocumentReference? = nil
        documentReference = db.collection("EventInfo").addDocument(data: ["eventname":toAdd.eventname, "payments":toAdd.payments, "participates": toAdd.participates]) { error in
            if let error = error {
                print("Error adding EventInfo document: \(error)")
            } else {
                let documentID = documentReference?.documentID
                print("EventInfo document added successfully with ID: \(documentID ?? "")")
                toAdd.id = documentID ?? ""
                db.collection("EventInfo").document(documentID!).updateData(["id": toAdd.id])
                self.allEvents = [:]
                self.get_EventInfo()
            }
        }
        let res = documentReference?.documentID
        return res
    }
    
    func add_Note(toAdd: Note)->String?{
        let db = Firestore.firestore()
        var documentReference: DocumentReference? = nil
        documentReference = db.collection("Note").addDocument(data: ["texts":toAdd.texts, "pictures":toAdd.pictures]){ error in
            // Check error
            if let error = error {
                print("Error adding Note document: \(error)")
            } else {
                let documentID = documentReference?.documentID
                print("Note document added successfully with ID: \(documentID ?? "")")
                toAdd.id = documentID ?? ""
                db.collection("Note").document(documentID!).updateData(["id": toAdd.id])
                self.get_Note()
            }
        }
        let res = documentReference?.documentID
        return res
    }
    
    func add_PaymentsDetail(toAdd: PaymentsDetail)->String?{
        let db = Firestore.firestore()
        var documentReference: DocumentReference? = nil
        documentReference = db.collection("PaymentsDetail").addDocument(data: ["paymentName":toAdd.paymentName, "expense":toAdd.expense, "category":toAdd.category.rawValue, "participates":toAdd.participates, "payers":toAdd.payers, "note": toAdd.note.texts[0], "time": toAdd.time]){ error in
            if let error = error {
                print("Error adding PaymentsDetail document: \(error)")
            } else {
                let documentID = documentReference?.documentID
                print("PaymentsDetail document added successfully with ID: \(documentID ?? "")")
                toAdd.id = documentID ?? ""
                db.collection("PaymentsDetail").document(documentID!).updateData(["id": toAdd.id])
                self.allPayments = [:]
                self.get_PaymentsDetail()
            }
        }
        let res = documentReference?.documentID
        return res
    }
    
    func add_PersonDetail(toAdd: PersonDetail)->String?{
        let db = Firestore.firestore()
        var documentReference: DocumentReference? = nil
        documentReference = db.collection("PersonDetail").addDocument(data: ["firstname":toAdd.firstname, "lastname":toAdd.lastname, "joinedEventNames":toAdd.joinedEventNames]){ error in
            // Check error
            if let error = error {
                print("Error adding PersonDetail document: \(error)")
            }
            else{
                let documentID = documentReference?.documentID
                print("PersonDetail document added successfully with ID: \(documentID ?? "")")
                toAdd.id = documentID ?? ""
                db.collection("PersonDetail").document(documentID!).updateData(["id": toAdd.id])
                self.personInfo = [:]
                self.get_PersonDetail()
            }
        }
        let res = documentReference?.documentID
        return res
    }
    
    
    // delete
    func delete_EventInfo(toDelete: EventInfo){
        let db = Firestore.firestore()
        
        db.collection("EventInfo").document(toDelete.id).delete{ error in
            if error == nil{
                
                DispatchQueue.main.async {
                    self.EventInfo_list.removeAll{ eventinfo in
                        return eventinfo.id == toDelete.id
                    }
                    self.allEvents.removeValue(forKey: toDelete.id)
                }
                
            }else{
                print("error in delete_EventInfo")
            }
        }
    }
    
    func delete_Note(toDelete: Note){
        let db = Firestore.firestore()
        
        db.collection("Note").document(toDelete.id).delete{ error in
            if error == nil{
                DispatchQueue.main.async {
                    self.Note_list.removeAll{ note in
                        return note.id == toDelete.id
                    }
                }
                
            }else{
                print("error in delete_Note")
            }
        }
    }
    
    func delete_PaymentsDetail(toDelete: PaymentsDetail){
        let db = Firestore.firestore()
        
        db.collection("PaymentsDetail").document(toDelete.id).delete{ error in
            if error == nil{
                
                DispatchQueue.main.async {
                    self.PaymentsDetail_list.removeAll{ paymentsdetail in
                        return paymentsdetail.id == toDelete.id
                    }
                    self.allPayments.removeValue(forKey: toDelete.id)
                }
                
            }else{
                print("error in delete_PaymentsDetail")
            }
        }
    }
    
    func delete_PersonDetail(toDelete: PersonDetail){
        let db = Firestore.firestore()
        
        db.collection("PersonDetail").document(toDelete.id).delete{ error in
            if error == nil{
                
                DispatchQueue.main.async {
                    self.PersonDetail_list.removeAll{ persondetail in
                        return persondetail.id == toDelete.id
                    }
                    self.personInfo.removeValue(forKey: toDelete.id)
                }
                
            }else{
                print("error in delete_PersonDetail")
            }
        }
    }
    
    
    
    // update
    func update_EventInfo(toUpdate: EventInfo){
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(toUpdate)
            let dictionary = try JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]

            let db = Firestore.firestore()
            try db.collection("EventInfo").document(toUpdate.id).setData(dictionary)
        } catch let error {
            print("Error updating EventInfo to Firestore: \(error)")
        }
    }
    
    func update_Note(toUpdate: Note){
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(toUpdate)
            let dictionary = try JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]

            let db = Firestore.firestore()
            try db.collection("Note").document(toUpdate.id).setData(dictionary)
        } catch let error {
            print("Error updating Note to Firestore: \(error)")
        }
    }
    
    func update_PaymentsDetail(toUpdate: PaymentsDetail){
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(toUpdate)
            let dictionary = try JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]

            let db = Firestore.firestore()
            try db.collection("PaymentsDetail").document(toUpdate.id).setData(dictionary)
        } catch let error {
            print("Error updating PaymentsDetail to Firestore: \(error)")
        }
    }
    
    func update_PersonDetail(toUpdate: PersonDetail){
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(toUpdate)
            let dictionary = try JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]

            let db = Firestore.firestore()
            try db.collection("PersonDetail").document(toUpdate.id).setData(dictionary)
        } catch let error {
            print("Error updating PersonDetail to Firestore: \(error)")
        }
    }
    
    
}
