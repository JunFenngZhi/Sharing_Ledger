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
    
    func addData(firstname: String, lastname: String, joinedEventNames: [String]){
        let db = Firestore.firestore()
        db.collection("PersonDetail").addDocument(data: ["firstname":firstname, "lastname":lastname, "joinedEventNames":joinedEventNames]){ error in
            // Check error
            if error == nil{
                // get data to retrieve latest data
                self.getData()
            }
            else{
                
            }
        }
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
    
}
