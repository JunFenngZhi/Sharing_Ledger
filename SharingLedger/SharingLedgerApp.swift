//
//  SharingLedgerApp.swift
//  SharingLedger
//
//  Created by mac on 2023/3/26.
//

import SwiftUI
import FirebaseCore

@main
struct SharingLedgerApp: App {
    @StateObject private var storageModel = StorageModel()
    @StateObject private var dukeStorageModel = DukeStorageModel()
    
    init(){
        FirebaseApp.configure()
        
        
    }

    var body: some Scene {
        WindowGroup {
            EntryView()
                .environmentObject(storageModel)
                .onAppear(){
                    dukeStorageModel.getDataFromServer(storageModel: storageModel)
                    print("start init storageModel")
                }
        }
    }
}
