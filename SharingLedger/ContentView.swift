//
//  ContentView.swift
//  SharingLedger
//
//  Created by mac on 2023/3/26.
//

import SwiftUI
import FirebaseCore

struct ContentView: View {
    
    @ObservedObject var model = ViewModel()
    
    @State var lastname = ""
    @State var firstname = ""
    @State var joinedEventNames = ""
    
    var body: some View {
//        Text("Hello, world!")
        VStack{
            List (model.list, id : \.self){ item in
                HStack{
                    Text(item.firstname+" "+item.lastname+" ")
                    
                    Spacer()
                    
                    //update
                    Button {
                        model.updateData_(toUpdate: item)
                    } label: {
                        Image(systemName: "pencil")
                    }
                    .buttonStyle(BorderlessButtonStyle())
                    
                    // delete
                    Button {
                        model.deleteData(toDelete: item)
                    } label: {
                        Image(systemName: "minus.circle")
                    }
                    .buttonStyle(BorderlessButtonStyle())
                }
            }
            Divider()
            
            
            // add data
            VStack(spacing: 5){
                TextField("FirstName", text: $firstname)
                
                TextField("LastName", text: $lastname)
                
                TextField("joinedEventNames", text: $joinedEventNames)
                
                let _ = PersonDetail(id: "test_id1", lname: lastname, fname: firstname, joinedEventNames: joinedEventNames.components(separatedBy: ","))
                let _ = PaymentsDetail(paymentName: "test_payment1", expense: 1234, category: Category.Restaurant, participates: ["Suchuan Xing", "Dingzhou Wang"], payers: ["Suchuan Xing"], note: "test_note", time: Date())
                Button(action: {
//                    model.add_PersonDetail(toAdd: pd)
//                    model.add_PaymentsDetail(toAdd: p_detail)
                    lastname = ""
                    firstname = ""
                    joinedEventNames = ""
                }, label: {
                    Text("Add PersonDeatils")
                })
            }
        }
        .padding()
    }
    
    init(){
        model.getData()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
