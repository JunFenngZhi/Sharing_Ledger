//
//  LoginRow.swift
//  SharingLedger
//
//  Created by mac on 2023/3/29.
//


import SwiftUI

struct LoginRow: View {
    
    @EnvironmentObject var storageModel: StorageModel
    var personDetail: PersonDetail
    
    var body: some View {
        HStack{
            SmallRoundImage(image: Image(uiImage: imageFromString(storageModel.personInfo[personDetail.firstname + " " + personDetail.lastname + "_ID"]!.picture)), width: 50, height: 50, shadowRadius: 0)
            Text(personDetail.firstname + " " + personDetail.lastname)
            
            Spacer()
        }
    }
}

struct LoginRow_Previews: PreviewProvider {
    static var previews: some View {
        LoginRow(personDetail: PersonDetail(id: "", lname: "Xing", fname: "Suchuan", joinedEventNames: [])).environmentObject(StorageModel())
    }
}

