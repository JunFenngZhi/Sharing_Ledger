//
//  HomePageView.swift
//  SharingLedger
//
//  Created by mac on 2023/3/30.
//

import SwiftUI

struct HomePageView: View {
    @EnvironmentObject var storageModel: StorageModel
    @State private var showSheet = false
    
    var name: String
    var joinedEventList: [EventInfo] {
        var res: [EventInfo] = []
        
        for eventName in storageModel.allEvents.keys {
            if storageModel.personInfo[name]!.joinedEventNames.contains(eventName){
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
                    SmallRoundImage(image: Image(uiImage: imageFromString(storageModel.personInfo[name]!.picture)), width: 28, height: 28, shadowRadius: 0)
                    Text("Welcome, " + name + "!")
                        .font(.custom("Inter", size: 15))
                        .fontWeight(.bold)
                    Spacer()
                }
                .padding(.leading)
                
                Button {
                    showSheet = true
                }label: {
                    AddEventRow()
                        .sheet(isPresented: $showSheet){
                            NewLedgerView(isNewLedgerShown: $showSheet)
                                .environmentObject(storageModel)
                        }
                }
                
                
                ForEach(joinedEventList, id: \.self){eventInfo in
                    NavigationLink {
                        EventView(eventName: eventInfo.eventname)
                            .environmentObject(storageModel)
                    }label: {
                        HomePageRow(eventName: eventInfo.eventname)
                            .environmentObject(storageModel)
                        
                    }
                }
                
            }
        }
        
    }
}

struct HomePageView_Previews: PreviewProvider {
    static var previews: some View {
        HomePageView(name: "Suchuan Xing").environmentObject(StorageModel())
    }
}
