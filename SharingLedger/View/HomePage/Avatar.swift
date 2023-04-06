//
//  Avatar.swift
//  SharingLedger
//
//  Created by mac on 2023/4/6.
//

import SwiftUI

struct Avatar: View {
    
    var personDetail: PersonDetail
    var body: some View {
        Image(uiImage: imageFromString(personDetail.picture))
            .resizable()
            .frame(width: 50, height: 50)
    }
}

struct Avatar_Previews: PreviewProvider {
    static var previews: some View {
        Avatar(personDetail: PersonDetail(id: "", lname: "Xing", fname: "Suchuan", joinedEventNames: []))
    }
}

