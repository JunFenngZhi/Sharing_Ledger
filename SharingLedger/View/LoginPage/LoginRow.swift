//
//  LoginRow.swift
//  SharingLedger
//
//  Created by mac on 2023/3/29.
//


import SwiftUI

struct LoginRow: View {
    
    
    var personDetail: PersonDetail
    
    var body: some View {
        HStack{
            Image(uiImage: imageFromString(personDetail.picture))
                .resizable()
                .frame(width: 50, height: 50)
            Text(personDetail.firstname + " " + personDetail.lastname)
            
            Spacer()
        }
    }
}

struct LoginRow_Previews: PreviewProvider {
    static var previews: some View {
        LoginRow(personDetail: PersonDetail(id: "", lname: "Xing", fname: "Suchuan", joinedEventNames: []))
    }
}

