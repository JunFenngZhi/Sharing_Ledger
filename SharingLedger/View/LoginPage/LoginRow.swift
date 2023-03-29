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
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct LoginRow_Previews: PreviewProvider {
    static var previews: some View {
        LoginRow(personDetail: PersonDetail(lname: "Xing", fname: "Suchuan"))
    }
}
