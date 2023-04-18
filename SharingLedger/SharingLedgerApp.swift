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
    //@StateObject private var dukeStorageModel = DukeStorageModel()
    
    init(){
        FirebaseApp.configure()
    }

    var body: some Scene {
        WindowGroup {
            EntryView()
                .environmentObject(storageModel)
                .onAppear(){
                    print("✅ Start init storageModel from firestore Database")
                    
                    //TODO: Use addSnapshotListener to monitor changes
                    // Create a timer that fires every 30 seconds and calls your function
                    let interval = 30
                    let timer = DispatchSource.makeTimerSource()
                    timer.schedule(deadline: .now(), repeating: .seconds(interval))
                    timer.setEventHandler(handler: {
                        print("✨ Sync StorageModel with firestore database ✨")
                        storageModel.initFromFireStoreDatabase()
                    })

                    // Start the timer on a background queue
                    let queue = DispatchQueue(label: "background refresh", qos: .background)
                    timer.activate()
                    timer.setCancelHandler(handler: {
                        queue.async {
                            timer.resume()
                        }
                    })
                }
        }
    }
}
