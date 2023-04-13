//
//  PlusButton.swift
//  SharingLedger
//
//  Created by mac on 2023/4/13.
//

import SwiftUI

struct PlusButton: View {
    var body: some View {
        ZStack{
            Circle()
                .fill(Color(#colorLiteral(red: 0.1585937738418579, green: 0.7221303582191467, blue: 0.8458333611488342, alpha: 1)))
                .frame(width: 40, height: 40)
            Text("+")
                .fontWeight(.bold)
                .font(.custom("Inter", size: 28))
                .offset(y:-2)
        }
    }
}

struct PlusButton_Previews: PreviewProvider {
    static var previews: some View {
        PlusButton()
    }
}
