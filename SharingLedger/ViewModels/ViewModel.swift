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
                                conclusion: d["conclusion"] as! Double,
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
                                paymentName: d["paymentName"] as! String,
                                expense: d["expense"] as! Double,
                                category: Category(rawValue: d["category"] as! String) ?? .Default,
                                participates: d["participates"] as! [String],
                                payers: d["payers"] as! [String],
                                note: d["note"] as! String,
                                time: d["time"] as! Date
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
            }
            
        }
    }
    
    
    // add
    func add_EventInfo(toAdd: EventInfo){
        let db = Firestore.firestore()
        db.collection("EventInfo").addDocument(data: ["eventname":toAdd.eventname, "conclusion":toAdd.conclusion, "payments":toAdd.payments, "participates": toAdd.participates]){ error in
            // Check error
            if error == nil{
                // get data to retrieve latest data
                self.get_EventInfo()
            }
            else{
                print("error in get_Note")
            }
        }
    }
    
    func add_Note(toAdd: Note){
        let db = Firestore.firestore()
        db.collection("Note").addDocument(data: ["texts":toAdd.texts, "pictures":toAdd.pictures]){ error in
            // Check error
            if error == nil{
                // get data to retrieve latest data
                self.get_Note()
            }
            else{
                print("error in get_Note")
            }
        }
    }
    
    func add_PaymentsDetail(toAdd: PaymentsDetail){
        let db = Firestore.firestore()
        db.collection("PaymentsDetail").addDocument(data: ["paymentName":toAdd.paymentName, "expense":toAdd.expense, "category":toAdd.category.rawValue, "participates":toAdd.participates, "payers":toAdd.payers, "note": toAdd.note.texts, "time": toAdd.time]){ error in
            // Check error
            if error == nil{
                // get data to retrieve latest data
                self.get_PersonDetail()
            }
            else{
                print("error in get_PersonDetail")
            }
        }
    }
    
    func add_PersonDetail(toAdd: PersonDetail){
        let db = Firestore.firestore()
        db.collection("PersonDetail").addDocument(data: ["firstname":toAdd.firstname, "lastname":toAdd.lastname, "joinedEventNames":toAdd.joinedEventNames]){ error in
            // Check error
            if error == nil{
                // get data to retrieve latest data
                self.get_PersonDetail()
            }
            else{
                print("error in get_PersonDetail")
            }
        }
    }
    
    
    // delete
    func delete_EventInfo(){}
    
    func delete_Note(){}
    
    func delete_PaymentsDetail(){}
    
    func delete_PersonDetail(){}
    
    
    // update
    func update_EventInfo(){}
    
    func update_Note(){}
    
    func update_PaymentsDetail(){}
    
    func update_PersonDetail(){}
    
    
}
