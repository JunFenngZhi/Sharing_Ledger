//
//  CircleImage.swift
//  SharingLedger
//
//  Created by Loaner on 3/29/23.
//

import SwiftUI

struct SmallCircleImage: View {
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
                Circle().stroke(.gray, lineWidth: 4)
            }
            .shadow(radius: shadowRadius)
    }

}

struct SmallCircleImage_Previews: PreviewProvider {
    static var previews: some View {
        SmallCircleImage(image: Image("Unknown"), width: 50, height: 50, shadowRadius: 7)
    }
}
