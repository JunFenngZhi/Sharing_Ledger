//
//  EventView.swift
//  SharingLedger
//
//  Created by Loaner on 4/3/23.
//

import SwiftUI

struct EventView: View {
    @State var showEditPaymentView: Bool = false
    
    var body: some View {
        ZStack{
            if showEditPaymentView == false{
                EventDetailsView(showEditPaymentView: $showEditPaymentView)
            }else{
                EditPaymentView(showEditPaymentView: $showEditPaymentView)
            }
            
        }
    }
}

struct EventView_Previews: PreviewProvider {
    static var previews: some View {
        EventView()
    }
}
