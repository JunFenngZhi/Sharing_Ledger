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
    @Environment(\.presentationMode) var presentationMode
    
    @State private var viewType: ViewType  = .EventDetailsView
    
    var body: some View {
        ZStack{
            if viewType == .EventDetailsView{
                EventDetailsView(eventName: "Development", viewType: $viewType)
                    .navigationBarBackButtonHidden(true)
                    .navigationBarItems(leading: backButton)
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
    
    private var backButton: some View {
        Button(action: {
            self.presentationMode.wrappedValue.dismiss()
        }, label: {
            HStack {
                Image(systemName: "chevron.backward").bold()
                Text("Event List")
                    .offset(x: -5)
            }
        })
        .foregroundColor(.blue)
        .offset(x: -10)
    }
}

struct EventView_Previews: PreviewProvider {
    static var previews: some View {
        EventView(eventName: "Development").environmentObject(StorageModel())
    }
}
