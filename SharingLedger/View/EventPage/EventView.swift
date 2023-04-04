//
//  EventView.swift
//  SharingLedger
//
//  Created by Loaner on 4/3/23.
//

import SwiftUI

struct EventView: View {
    let eventName: String
    @EnvironmentObject var storageModel: StorageModel
    @State private var showEditPaymentView: Bool = false
    
    var body: some View {
        ZStack{
            if showEditPaymentView == false{
                EventDetailsView(eventName: "Development", showEditPaymentView: $showEditPaymentView)
            }else{
                EditPaymentView(eventName: "Development", showEditPaymentView: $showEditPaymentView)
            }
            
        }
    }
}

struct EventView_Previews: PreviewProvider {
    static var previews: some View {
        EventView(eventName: "Development").environmentObject(StorageModel())
    }
}
