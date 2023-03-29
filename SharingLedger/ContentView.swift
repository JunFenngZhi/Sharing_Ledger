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
    
    var body: some View {
        Text("Hello, world!")
        List (model.list, id : \.self){ item in
            Text(item.firstname+" "+item.lastname+" ")
        }
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
