//
//  GrowingButtonStyle.swift
//  SharingLedger
//
//  Created by Loaner on 3/29/23.
//

import SwiftUI

struct GrowingButton: ButtonStyle {
    let backGroundColor: Color
    let foreGroundColor: Color
    
    init(backGroundColor: Color, foreGroundColor: Color){
        self.backGroundColor = backGroundColor
        self.foreGroundColor = foreGroundColor
    }
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(backGroundColor)
            .foregroundColor(foreGroundColor)
            .clipShape(Capsule())
            .scaleEffect(configuration.isPressed ? 1.2 : 1)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
    }
}
