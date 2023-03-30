//
//  LoginView.swift
//  SharingLedger
//
//  Created by mac on 2023/3/28.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var storageModel: StorageModel
    
    var personlist: [PersonDetail] {
        var res: [PersonDetail] = []
        for person in storageModel.personInfo.values {
            res.append(person)
        }
        return res
    }
    
    var body: some View {
        VStack{
            Text("Welcome To Sharing Ledger")
                .lineLimit(2)
                .font(.custom("Inter", size: 40))
            
            NavigationView {
                List(personlist) { person in
                    NavigationLink {
                        HomePageView()
                    } label: {
                        LoginRow(personDetail: person)
                    }
                }
                .navigationTitle("Who Are You?")
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
