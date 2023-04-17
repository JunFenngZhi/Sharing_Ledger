//
//  FireStoreManager.swift
//  SharingLedger
//
//  Created by Loaner on 4/17/23.
//

import Foundation
import FirebaseCore
import FirebaseFirestore

class FireStoreManager{
    
    /// update a document in PersonDetail column in firestore database.
    func updatePersonDetail(toUpdate: PersonDetail){
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(toUpdate)
            let dictionary = try JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
            
            let db = Firestore.firestore()
            db.collection("PersonDetail").document(toUpdate.id).setData(dictionary){ error in
                if let error = error {
                    print("❗️ Error[updatePersonDetail]: Fail to update PersonDetail \(toUpdate.fullname). Details:" + error.localizedDescription)
                } else {
                    print("✅ PersonDetail \(toUpdate.fullname) update successfully!")
                }
            }
        } catch let error {
            print("❗️ Error[updatePersonDetail]: Fail to generate dictionary. Details:" + error.localizedDescription)
        }
    }
    
    /// update a document in EventInfo column in firestore database
    func updateEventInfo(toUpdate: EventInfo){
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(toUpdate)
            let dictionary = try JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]

            let db = Firestore.firestore()
            db.collection("EventInfo").document(toUpdate.id).setData(dictionary){ error in
                if let error = error {
                    print("❗️ Error[updateEventInfo]: Fail to update EventInfo \(toUpdate.eventname). Details:" + error.localizedDescription)
                } else {
                    print("✅ EventInfo \(toUpdate.eventname) update successfully!")
                }
            }
        } catch let error {
            print("❗️ Error[updateEventInfo]: Fail to generate dictionary. Details:" + error.localizedDescription)
        }
    }
}
