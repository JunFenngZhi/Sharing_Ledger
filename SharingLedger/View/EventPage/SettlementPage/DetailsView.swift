//
//  DetailsView.swift
//  SharingLedger
//
//  Created by Loaner on 4/11/23.
//

import SwiftUI

struct DetailsView: View {
    let myPersonID: String
    let transferList: [(String, Double)]
    let columnMaxWidth: CGFloat = 100
    let columnMinWidth: CGFloat = 0
    
    @EnvironmentObject var storageModel: StorageModel
    
    var body: some View {
        let myPersonInfo = storageModel.personInfo[myPersonID]!
        
        VStack(spacing: 30){
            ForEach(transferList, id: \.0) { tuple in
                let counterPersonInfo = storageModel.personInfo[tuple.0]!
                let amount = tuple.1
                let payer = amount > 0 ? myPersonInfo : counterPersonInfo
                let payee = amount > 0 ? counterPersonInfo : myPersonInfo
                
                VStack{
                    HStack(){
                        Spacer()
                        
                        VStack(alignment: .center){
                            SmallRoundImage(image: Image(uiImage: imageFromString(payer.picture)), width: 30, height: 30, shadowRadius: 3)
                            Text(payer.firstname + " " + payer.lastname).font(.footnote)
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
                            SmallRoundImage(image: Image(uiImage: imageFromString(payee.picture)), width: 30, height: 30, shadowRadius: 3)
                            Text(payee.firstname + " " + payee.lastname).font(.footnote)
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
        DetailsView(myPersonID: "Junfeng Zhi_ID", transferList: [("Suchuan Xing_ID", 123.45),("Dingzhou Wang_ID", -456.78)]).environmentObject(StorageModel())
    }
}
