//
//  SwiftUIView.swift
//  SharingLedger
//
//  Created by Loaner on 3/30/23.
//

import SwiftUI

struct OverlapPersonPicture: View {
    @EnvironmentObject var storageModel: StorageModel
    
    let personIdList:[String]
    var image: Image = Image("Unknown")
    
    var body: some View {
        ZStack{
            ForEach(0..<2) { index in
                if(index < personIdList.count){
                    let personInfo = storageModel.personInfo[personIdList[index]]!
                    Image(uiImage: imageFromString(personInfo.picture))
                        .resizable()
                        .frame(width: 30, height: 30)
                        .clipShape(Circle())
                        .overlay{
                            Circle().stroke(.gray, lineWidth: 4)
                        }
                        .offset(x: -50 + CGFloat(index * 20))
                        .shadow(radius: 3)
                }
            }
            Circle()
                .frame(width: 30, height: 30)
                .foregroundColor(.pink)
                .shadow(radius: 3)
                .offset(x: personIdList.count > 1 ? -50 + CGFloat(2 * 20) : -70 + CGFloat(2 * 20))
            Text("\(personIdList.count)")
                .offset(x: personIdList.count > 1 ? -10 : -30)
        }
    }
}

struct OverlapPersonPicture_Previews: PreviewProvider {
    static var previews: some View {
        OverlapPersonPicture(personIdList: ["Junfeng Zhi_ID", "Dingzhou Wang_ID", "Suchuan Xing_ID"]).environmentObject(StorageModel())
    }
}
