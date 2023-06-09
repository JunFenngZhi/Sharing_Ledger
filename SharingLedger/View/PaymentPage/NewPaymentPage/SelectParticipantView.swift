//
//  SelectParticipantView.swift
//  SharingLedger
//
//  Created by Loaner on 4/5/23.
//

import SwiftUI

struct SelectParticipantView: View {
    let participants: [String]
    
    @EnvironmentObject var storageModel: StorageModel
    
    @Binding var selectedParticipants: Set<String>
    @Binding var showSelectParticipantsView: Bool
    
    var body: some View {
        VStack{
            Text("Select Participants")
                .font(.title)
                .bold()
                .foregroundColor(themeColor)
                .padding([.vertical])

            
            List(){
                ForEach(participants, id: \.self){ personID in
                    let personInfo = storageModel.personInfo[personID]!
                    Button {
                        if selectedParticipants.contains(personID) == true{
                            selectedParticipants.remove(personID)
                        }else{
                            selectedParticipants.insert(personID)
                        }
                    } label: {
                        HStack{
                            SmallRoundImage(image: Image(uiImage: imageFromString(personInfo.picture)), width: 50, height: 50, shadowRadius: 7).padding(.trailing)
                            Text(personInfo.firstname + " " + personInfo.lastname).foregroundColor(.black)
                            Spacer()
                            if selectedParticipants.contains(personID) == true{
                                Image(systemName: "checkmark.circle")
                            }
                        }
                    }
                }
            }
            
            HStack{
                Spacer()
                Button {
                    selectedParticipants.removeAll()
                } label: {
                    Text("  Clear  ")
                }
                .buttonStyle(GrowingButton(backGroundColor: themeColor, foreGroundColor: .white))
                .frame(maxWidth: .infinity, maxHeight: 50)
                
                Spacer()
                
                Button {
                    showSelectParticipantsView.toggle()
                } label: {
                    Text(" Confrom ")
                }
                .buttonStyle(GrowingButton(backGroundColor: themeColor, foreGroundColor: .white))
                .frame(maxWidth: .infinity, maxHeight: 50)
                
                Spacer()
            }
        }
    }
}

struct SelectParticipantView_Previews: PreviewProvider {
    @State static var selectedParticipants: Set<String> = []
    static var previews: some View {
        SelectParticipantView(participants: ["Junfeng Zhi_ID", "Suchuan Xing_ID", "Dingzhou Wang_ID"], selectedParticipants: $selectedParticipants, showSelectParticipantsView: .constant(true)).environmentObject(StorageModel())
    }
}
