//
//  SmallRoundImage.swift
//  SharingLedger
//
//  Created by mac on 2023/4/13.
//

import SwiftUI

struct SmallRoundImage: View {
    var image: Image
    var width: CGFloat
    var height: CGFloat
    var shadowRadius: CGFloat
    
    var body: some View {
        image
            .resizable()
            .frame(width: width, height: height)
            .clipShape(Circle())
            .overlay{
                Circle().stroke(.gray, lineWidth: 0)
            }
            .shadow(radius: shadowRadius)
    }
}

struct SmallRoundImage_Previews: PreviewProvider {
    static var previews: some View {
        SmallRoundImage(image: Image("Unknown"), width: 50, height: 50, shadowRadius: 7)
    }
}
