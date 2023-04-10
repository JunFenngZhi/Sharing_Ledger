//
//  SelectParticipantView.swift
//  SharingLedger
//
//  Created by Loaner on 4/5/23.
//

import SwiftUI

struct SelectParticipantView: View {
    let participants: [String]
    
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
                ForEach(participants.indices){ i in
                    Button {
                        if selectedParticipants.contains(participants[i]) == true{
                            selectedParticipants.remove(participants[i])
                        }else{
                            selectedParticipants.insert(participants[i])
                        }
                    } label: {
                        HStack{
                            SmallCircleImage(image: Image("Unknown"), width: 50, height: 50, shadowRadius: 7).padding(.trailing)
                            Text(participants[i]).foregroundColor(.black)
                            Spacer()
                            if selectedParticipants.contains(participants[i]) == true{
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
        SelectParticipantView(participants: ["Junfeng Zhi", "Suchuan Xing", "Dingzhou Wang"], selectedParticipants: $selectedParticipants, showSelectParticipantsView: .constant(true))
    }
}
