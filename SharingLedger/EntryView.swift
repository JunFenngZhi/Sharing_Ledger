//
//  EntryView.swift
//  SharingLedger
//
//  Created by mac on 2023/4/12.
//

import SwiftUI

struct EntryView: View {
    @EnvironmentObject var storageModel: StorageModel
    var body: some View {
        LoginView()
            .environmentObject(storageModel)
    }
}

struct EntryView_Previews: PreviewProvider {
    static var previews: some View {
        EntryView()
    }
}
