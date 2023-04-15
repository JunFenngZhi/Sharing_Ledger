//
//  HomePageView.swift
//  SharingLedger
//
//  Created by mac on 2023/3/30.
//

import SwiftUI

struct HomePageView: View {
    
    @EnvironmentObject var storageModel: StorageModel
    @Environment(\.presentationMode) var presentationMode
    @State private var showSheet = false
    
    var personID: String
    var joinedEventList: [EventInfo] {
        var res: [EventInfo] = []
        
        for eventName in storageModel.allEvents.keys {
            if storageModel.personInfo[personID]!.joinedEventNames.contains(eventName){
                res.append(storageModel.allEvents[eventName]!)
            }
        }
        return res
    }
    
    
    var body: some View {
        ScrollView{
            VStack{
                Text("Sharing Ledger")
                    .font(.custom("Inter", size: 30))
                    .fontWeight(.bold)
                HStack{
                    SmallRoundImage(image: Image(uiImage: imageFromString(storageModel.personInfo[personID]!.picture)), width: 28, height: 28, shadowRadius: 0)
                    Text("Welcome, " + storageModel.personInfo[personID]!.fullname + "!")
                        .font(.custom("Inter", size: 15))
                        .fontWeight(.bold)
                    Spacer()
                }
                .padding(.leading)
                
                Button {
                    showSheet = true
                }label: {
                    AddEventRow()
                        .foregroundColor(.black)
                        .sheet(isPresented: $showSheet){
                            NewLedgerView(isNewLedgerShown: $showSheet)
                                .environmentObject(storageModel)
                        }
                }
                
                
                ForEach(joinedEventList, id: \.self){eventInfo in
                   
                    HomePageRow(eventID: eventInfo.id)
                        .environmentObject(storageModel)
                        .foregroundColor(.black)
                        
                    
                }
                
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: backButton)
        
    }
    
    private var backButton: some View {
        Button(action: {
            self.presentationMode.wrappedValue.dismiss()
        }, label: {
            HStack {
                Image(systemName: "chevron.backward").bold()
                Text("Login")
                    .offset(x: -5)
            }
        })
        .foregroundColor(.blue)
        .offset(x: -10)
    }
}

struct HomePageView_Previews: PreviewProvider {
    static var previews: some View {
        HomePageView(personID: "Suchuan Xing_ID").environmentObject(StorageModel())
    }
}
