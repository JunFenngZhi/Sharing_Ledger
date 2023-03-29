//
//  CircleImage.swift
//  SharingLedger
//
//  Created by Loaner on 3/29/23.
//

import SwiftUI

struct PaymentRowCircleImage: View {
    var image: Image
    var body: some View {
        image
            .resizable()
            .frame(width: 50, height: 50)
            .clipShape(Circle())
            .overlay{
                Circle().stroke(.gray, lineWidth: 4)
            }
            .shadow(radius: 7)
    }

}

struct PaymentRowCircleImage_Previews: PreviewProvider {
    static var previews: some View {
        PaymentRowCircleImage(image: Image("testImage"))
    }
}
