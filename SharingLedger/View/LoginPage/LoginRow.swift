//
//  LoginRow.swift
//  SharingLedger
//
//  Created by mac on 2023/3/29.
//


import SwiftUI

struct LoginRow: View {
    
    @EnvironmentObject var storageModel: StorageModel
    var personID: String
    
    var body: some View {
        HStack{
            SmallRoundImage(image: Image(uiImage: imageFromString(storageModel.personInfo[personID]!.picture)), width: 50, height: 50, shadowRadius: 0)
            Text(storageModel.personInfo[personID]!.fullname)
            //Text(storageModel.personInfo[personID]!.id)
            
            Spacer()
        }
    }
}

struct LoginRow_Previews: PreviewProvider {
    static var previews: some View {
        LoginRow(personID: "Suchuan Xing_ID").environmentObject(StorageModel())
    }
}

