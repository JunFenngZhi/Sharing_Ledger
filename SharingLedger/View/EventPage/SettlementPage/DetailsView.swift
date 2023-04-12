//
//  DetailsView.swift
//  SharingLedger
//
//  Created by Loaner on 4/11/23.
//

import SwiftUI

struct DetailsView: View {
    let myName: String
    let transferList: [(String, Double)]
    let columnMaxWidth: CGFloat = 100
    let columnMinWidth: CGFloat = 0
    
    
    @EnvironmentObject var storageModel: StorageModel
    
    var body: some View {
        VStack(spacing: 30){
            ForEach(transferList, id: \.0) { tuple in
                let amount = tuple.1
                let payer = amount > 0 ? myName : tuple.0
                let payee = amount > 0 ? tuple.0 : myName
                VStack{
                    HStack(){
                        Spacer()
                        
                        VStack(alignment: .center){
                            SmallCircleImage(image: Image("Unknown"), width: 30, height: 30, shadowRadius: 3)
                            Text(payer).font(.footnote)
                        }
                        .frame(minWidth:columnMinWidth, maxWidth:columnMaxWidth)
                        
                        Spacer()
                        
                        VStack(alignment: .center){
                            Image("RightArrow")
                                .resizable()
                                .frame(width: 50, height: 30)
                            Text("pays").font(.subheadline).foregroundColor(.gray)
                        }
                        .frame(minWidth:columnMinWidth, maxWidth:columnMaxWidth)
                        
                        Spacer()
                        
                        VStack(alignment: .center){
                            SmallCircleImage(image: Image("Unknown"), width: 30, height: 30, shadowRadius: 3)
                            Text(payee).font(.footnote)
                        }
                        .frame(minWidth:columnMinWidth, maxWidth:columnMaxWidth)
                        
                        Spacer()
                    }
                    HStack(){
                        Text("US$" + String(format:"%.2f",abs(amount))).font(.title2)
                        Spacer()
                        Button {
                            //TODO: add notification
                        } label: {
                            Text("Notify").font(.title2)
                                .foregroundColor(amount > 0 && isZero_Double(num: abs(amount)) == false ? Color.red : Color.green)
                        }.offset(x:-15)
                    }.padding(.horizontal, 30)
                }
            }
        }
    }
}

struct DetailsView_Previews: PreviewProvider {
    static var previews: some View {
        DetailsView(myName: "Junfeng Zhi", transferList: [("tom", 123.45),("jason", -456.78)]).environmentObject(StorageModel())
    }
}
