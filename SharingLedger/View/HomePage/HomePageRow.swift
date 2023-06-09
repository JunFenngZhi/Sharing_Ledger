//
//  HomePageRow.swift
//  SharingLedger
//
//  Created by mac on 2023/4/6.
//

import SwiftUI

struct HomePageRow: View {
    @EnvironmentObject var storageModel: StorageModel
    @State private var showSheet = false
    let personID: String
    let eventID: String
    var joinedPeopleNumberObservedLessThanFourID: [String] {
        let joinedPeopleNumber = storageModel.allEvents[eventID]!.participates.count >= 4 ? 4 : storageModel.allEvents[eventID]!.participates.count
        var res : [String] = []
        var start = 0
        for personid in storageModel.allEvents[eventID]!.participates {
            
            if start < joinedPeopleNumber {
                res.append(personid)
            }
            start += 1
        }
        return res
    }
    
    var body: some View {
        //NavigationView{
            VStack{
//                HStack{
//                    Spacer()
//                    Text("created at " + printDate(date: storageModel.allEvents[eventID]!.createdTime)).font(.custom("Inter Light", size: 10)).multilineTextAlignment(.trailing)
//                        .offset(x: -30)
//                }
                
                ZStack{
                    NavigationLink {
                        EventView(eventID: eventID)
                            .environmentObject(storageModel)
                        }label: {
                            Rectangle()
                                .fill(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
                                .frame(width: 332, height: 133)
                                .shadow(color: Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.25)), radius:4, x:0, y:4)
                    }
                    
                    VStack{
                        
                        Text(storageModel.allEvents[eventID]!.eventname)
                            .padding(.leading, -150)
                            .font(.custom("Inter Bold", size: 14)).multilineTextAlignment(.center)
                        
                        
                        Button {
                            showSheet = true
                        }label: {
                            HStack{
                                // TODO: fix bug here. delete 1 people will cause error
                                
                                ForEach (joinedPeopleNumberObservedLessThanFourID, id: \.self) {personID in
                                    SmallRoundImage(image: Image(uiImage: imageFromString(storageModel.personInfo[personID]!.picture)), width: 35, height: 35, shadowRadius: 0)
                                }
                                
                                
                                
                                
                                Text("...").font(.custom("Inter Bold", size: 14)).multilineTextAlignment(.center)
                                
                                PlusButton()
                                
                                
                            }
                                
                                .sheet(isPresented: $showSheet){
                                    AddPeopleView(eventID: eventID, isNewLedgerShown: $showSheet)
//                                        .environmentObject(storageModel)
                                }
                        }
                        
                        
                        
                        Divider()
                            .frame(width: 310)
                        HStack{
                            Spacer()
                            
                            Text("my payment  US$ "+String(storageModel.calculatePaymentForOnePerson(personID: personID, eventID: eventID))).font(.custom("Inter Bold", size: 10)).multilineTextAlignment(.center)
                                .offset(x:-40)
                        }
                    }
                    
                }
                
            }
        //}
    }
}

struct HomePageRow_Previews: PreviewProvider {
    static var previews: some View {
        HomePageRow(personID: "Suchuan",eventID: "Development_ID").environmentObject(StorageModel())
    }
}
