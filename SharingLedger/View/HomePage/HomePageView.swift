//
//  HomePageView.swift
//  SharingLedger
//
//  Created by mac on 2023/3/30.
//

import SwiftUI

struct HomePageView: View {
    @EnvironmentObject var storageModel: StorageModel
    
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
                
                AddEventRow()
                
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
        HomePageView(name: "Suchuan Xing")
    }
}
