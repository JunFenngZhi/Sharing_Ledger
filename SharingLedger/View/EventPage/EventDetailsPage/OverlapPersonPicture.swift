//
//  SwiftUIView.swift
//  SharingLedger
//
//  Created by Loaner on 3/30/23.
//

import SwiftUI

struct OverlapPersonPicture: View {
    let nameList:[String]
    var image: Image = Image("Unknown") //TODO: placeHoder,get image through environmentObject
    
    var body: some View {
        ZStack{
            ForEach(0..<2) { index in
                image
                    .resizable()
                    .frame(width: 30, height: 30)
                    .clipShape(Circle())
                    .overlay{
                        Circle().stroke(.gray, lineWidth: 4)
                    }
                    .offset(x: -50 + CGFloat(index * 20))
                    .shadow(radius: 7)
            }
            Circle()
                .frame(width: 30, height: 30)
                .foregroundColor(.pink)
                .shadow(radius: 7)
                .offset(x: -50 + CGFloat(2 * 20))
            Text("\(nameList.count)")
                .offset(x: -10)
        }
    }
}

struct OverlapPersonPicture_Previews: PreviewProvider {
    static var previews: some View {
        OverlapPersonPicture(nameList: ["Junfeng", "DingZhou", "Suchuan"])
    }
}
