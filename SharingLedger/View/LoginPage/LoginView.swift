//
//  LoginView.swift
//  SharingLedger
//
//  Created by mac on 2023/3/28.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var storageModel: StorageModel
    
    var personlist: [String] {
        var res: [String] = []
        for personID in storageModel.personInfo.keys {
            res.append(personID)
        }
        return res
    }
    
    var body: some View {
        VStack{
            NavigationView {
                VStack{
                    Text("Welcome To Sharing Ledger")
                        .lineLimit(2)
                        .font(.custom("Inter", size: 40))
                    Divider()
                    
                    Text("Who Are You?")
                        .lineLimit(2)
                        .font(.custom("AmericanTypewriter", size: 25))
                    
                    List(personlist, id: \.self) { personID in
                        NavigationLink {
                            HomePageView(personID: personID)
                                .environmentObject(storageModel)
                        } label: {
                            LoginRow(personID: personID)
                                .environmentObject(storageModel)
                        }
                    }
                    
                }
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView().environmentObject(StorageModel())
    }
}
