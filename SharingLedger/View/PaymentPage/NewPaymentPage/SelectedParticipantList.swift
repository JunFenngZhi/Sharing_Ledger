//
//  ParticipantList.swift
//  SharingLedger
//
//  Created by Loaner on 4/5/23.
//

import SwiftUI

struct SelectedParticipantList: View {
    let selectedParticipant: Set<String>
    var image: Image = Image("Unknown") //TODO: placeholder,get image through environmentObject
    
    var body: some View {
        HStack(){
            ForEach(0..<3) { index in
                if(index < selectedParticipant.count){
                    Image("Unknown")
                       .resizable()
                       .frame(width: 40, height: 40)
                       .clipShape(Circle())
                       .overlay{
                           Circle().stroke(.gray, lineWidth: 4)
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
        SelectedParticipantList(selectedParticipant: ["123","456","789","222"])
    }
}
