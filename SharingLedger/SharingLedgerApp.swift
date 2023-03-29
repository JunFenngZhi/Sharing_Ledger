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

    init(){
        FirebaseApp.configure()
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
