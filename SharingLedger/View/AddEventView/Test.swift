//
//  Test.swift
//  SharingLedger
//
//  Created by mac on 2023/4/13.
//

import SwiftUI

struct Test: View {
    @State private var selection = 0
        let options = ["Option 1", "Option 2", "Option 3", "Option 4", "Option 5"]

        var body: some View {
            VStack {
                Text("Selected option: \(options[selection])")

                Picker("", selection: $selection) {
                                ForEach(0..<options.count) { index in
                                    Text(options[index])
                                }
                            }
                            .pickerStyle(.wheel)
                            .frame(height: 150)
                            .clipped()
                .onChange(of: selection) { value in
                    print("Selected option: \(options[value])")
                    // perform any action here
                }
            }
        }
}

struct Test_Previews: PreviewProvider {
    static var previews: some View {
        Test()
    }
}
