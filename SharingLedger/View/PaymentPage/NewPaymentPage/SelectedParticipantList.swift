//
//  ParticipantList.swift
//  SharingLedger
//
//  Created by Loaner on 4/5/23.
//

import SwiftUI

struct SelectedParticipantList: View {
    @EnvironmentObject var storageModel: StorageModel
    
    let selectedParticipant: Set<String>
    
    var body: some View {
        HStack(){
            let firstThree = Array(selectedParticipant.prefix(3))
            ForEach(0..<3) { index in
                if(index < selectedParticipant.count){
                    let personInfo = storageModel.personInfo[firstThree[index]]!
                    Image(uiImage: imageFromString(personInfo.picture))
                       .resizable()
                       .frame(width: 40, height: 40)
                       .clipShape(Circle())
                       .overlay{
                           Circle().stroke(.gray, lineWidth: 1)
                       }
                       .offset(x: CGFloat(index * -15))
                       .shadow(radius: 3)
                }
            }
            if(selectedParticipant.count > 3){
                Text("...")
                    .font(.subheadline)
                    .foregroundColor(Color.gray)
                    .offset(x: -30)
            }
            Spacer()
            Text("\(selectedParticipant.count) people in total")
                .font(.subheadline)
                .foregroundColor(.gray)
        }
    }
}

struct SelectedParticipantList_Previews: PreviewProvider {
    static var previews: some View {
        SelectedParticipantList(selectedParticipant: ["Junfeng Zhi_ID", "Dingzhou Wang_ID", "Suchuan Xing_ID"]).environmentObject(StorageModel())
    }
}
