//
//  SettlementView.swift
//  SharingLedger
//
//  Created by Loaner on 4/10/23.
//

import SwiftUI

struct SettlementView: View {
    let eventName: String
    
    @EnvironmentObject var storageModel: StorageModel
    
    @State var selectedRow: Int?
    @Binding var viewType: ViewType

    var body: some View {
        let event: EventInfo = storageModel.allEvents[eventName]!
        let conclusion: EventConclusion = event.conclusion
        VStack{
            HStack{
                backButton
                Spacer()
                Text("Settlement Page").font(.title).bold()
                    .offset(x: -10)
                Spacer()
            }.background(themeColor)
            
            Text("Reminder: This app only provides the settlement plan. The actual payments need to be done using other methods, like transfering through venmo or zelle.")
                .font(.subheadline)
                .foregroundColor(.gray)
                .padding(.vertical, -5)
            
            List{
                ForEach(event.participates.indices) { index in
                    let personName = event.participates[index]
                    
                    VStack {
                        PersonRow(picture: Image("Unknown"), name: personName, payAmount: conclusion.personExpenseList[personName]!, index: index, selectedRow: $selectedRow)
                        .padding(.vertical, 10)
                        .padding(.leading, -10)
                        .onTapGesture {
                            selectedRow = selectedRow == index ? nil : index
                        }
                        
                        // settlement details for each person
                        if selectedRow == index {
                            DetailsView(myName: personName, transferList: conclusion.allSettlementResults[personName]!)
                            .padding(.horizontal, -40)
                            .padding(.vertical)
                        }
                    }
                }
                .listRowBackground(Color.white)
            }
        }
       
    }
    
    private var backButton: some View {
        Button(action: {
            viewType = .EventDetailsView
        }, label: {
            HStack {
                Image(systemName: "arrow.left")
            }
        })
        .foregroundColor(.blue)
        .padding(.leading, 10)
    }
}

struct SettlementView_Previews: PreviewProvider {
    @State static var viewType: ViewType = .SettlementView
    static var previews: some View {
        SettlementView(eventName: "Development", viewType: $viewType).environmentObject(StorageModel())
    }
}
