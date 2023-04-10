//
//  SelectPersonView.swift
//  SharingLedger
//
//  Created by Loaner on 4/4/23.
//

import SwiftUI

struct SelectPayerView: View {
    let participants: [String]
    
    @Binding var selectedPayer: Set<String>
    @Binding var showSelectPayerView: Bool
    
    //TODO: support each payer pays different amount of money
    var body: some View {
        VStack{
            Text("Select Payer")
                .font(.title)
                .bold()
                .foregroundColor(themeColor)
                .padding([.vertical])

            
            List(){
                ForEach(participants.indices){ i in
                    Button {
                        if selectedPayer.contains(participants[i]) == true{
                            selectedPayer.remove(participants[i])
                        }else{
                            selectedPayer.insert(participants[i])
                        }
                    } label: {
                        HStack{
                            SmallCircleImage(image: Image("Unknown"), width: 50, height: 50, shadowRadius: 7).padding(.trailing)
                            Text(participants[i]).foregroundColor(.black)
                            Spacer()
                            if selectedPayer.contains(participants[i]) == true{
                                Image(systemName: "checkmark.circle")
                            }
                        }
                    }
                }
            }
            
            HStack{
                Spacer()
                Button {
                    selectedPayer.removeAll()
                } label: {
                    Text("  Clear  ")
                }
                .buttonStyle(GrowingButton(backGroundColor: themeColor, foreGroundColor: .white))
                .frame(maxWidth: .infinity, maxHeight: 50)
                
                Spacer()
                
                Button {
                    showSelectPayerView.toggle()
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

struct SelectPayerView_Previews: PreviewProvider {
    @State static var selectedPayer: Set<String> = []
    static var previews: some View {
        SelectPayerView(participants: ["Junfeng Zhi", "Suchuan Xing", "Dingzhou Wang"], selectedPayer: $selectedPayer, showSelectPayerView: .constant(true))
    }
}
