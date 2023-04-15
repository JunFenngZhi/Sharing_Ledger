//
//  SelectPersonView.swift
//  SharingLedger
//
//  Created by Loaner on 4/4/23.
//

import SwiftUI

struct SelectPayerView: View {
    let participants: [String]  // person id
    
    @EnvironmentObject var storageModel: StorageModel
    
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
                    let personInfo = storageModel.personInfo[participants[i]]!
                    Button {
                        if selectedPayer.contains(participants[i]) == true{
                            selectedPayer.remove(participants[i])
                        }else{
                            selectedPayer.insert(participants[i])
                        }
                    } label: {
                        HStack{
                            SmallCircleImage(image: Image(uiImage: imageFromString(personInfo.picture)), width: 50, height: 50, shadowRadius: 7).padding(.trailing)
                            Text(personInfo.firstname + " " + personInfo.lastname).foregroundColor(.black)
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
        SelectPayerView(participants: ["Junfeng Zhi_ID", "Suchuan Xing_ID", "Dingzhou Wang_ID"], selectedPayer: $selectedPayer, showSelectPayerView: .constant(true)).environmentObject(StorageModel())
    }
}
