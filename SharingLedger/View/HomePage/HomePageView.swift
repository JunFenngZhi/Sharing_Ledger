//
//  HomePageView.swift
//  SharingLedger
//
//  Created by mac on 2023/3/30.
//

import SwiftUI

struct HomePageView: View {
    var body: some View {
        ScrollView{
            VStack{
                HomePageRow()
                HomePageRow()
                HomePageRow()
                HomePageRow()
                
            }
        }
        
    }
}

struct HomePageView_Previews: PreviewProvider {
    static var previews: some View {
        HomePageView()
    }
}
