//
//  EventView.swift
//  SharingLedger
//
//  Created by Loaner on 4/3/23.
//

import SwiftUI

enum ViewType: String{
    case EventDetailsView = "EventDetails"
    case NewPaymentView = "NewPaymentView"
    case SettlementView = "SettlementView"
}

struct EventView: View {
    let eventName: String
    @EnvironmentObject var storageModel: StorageModel
    @State private var viewType: ViewType  = .EventDetailsView
    
    var body: some View {
        ZStack{
            if viewType == .EventDetailsView{
                EventDetailsView(eventName: "Development", viewType: $viewType)
            }else if viewType == .NewPaymentView{
                NewPaymentView(eventName: "Development", viewType: $viewType)
                    .navigationBarBackButtonHidden(true)
                    .transition(.move(edge: .trailing))
            }else{
                SettlementView(eventName: "Development", viewType: $viewType)
                    .navigationBarBackButtonHidden(true)
                    .transition(.move(edge: .trailing))
            }
            
        }
    }
}

struct EventView_Previews: PreviewProvider {
    static var previews: some View {
        EventView(eventName: "Development").environmentObject(StorageModel())
    }
}
