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
    @State private var showNewPaymentView: Bool = false
    
    var body: some View {
        ZStack{
            if showNewPaymentView == false{
                EventDetailsView(eventName: "Development", showNewPaymentView: $showNewPaymentView)
            }else{
                NewPaymentView(eventName: "Development", showNewPaymentView: $showNewPaymentView)
            }
            
        }
    }
}

struct EventView_Previews: PreviewProvider {
    static var previews: some View {
        EventView(eventName: "Development").environmentObject(StorageModel())
    }
}
