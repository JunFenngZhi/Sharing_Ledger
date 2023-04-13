//
//  LoginView.swift
//  SharingLedger
//
//  Created by mac on 2023/3/28.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var storageModel: StorageModel
    
    @State private var showingWelcomeView = false
    var personlist: [PersonDetail] {
        var res: [PersonDetail] = []
        for person in storageModel.personInfo.values {
            res.append(person)
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
                    
                    List(personlist) { person in
                        NavigationLink {
                            HomePageView(name: person.firstname + " " + person.lastname)
                                .environmentObject(storageModel)
                        } label: {
                            LoginRow(personDetail: person)
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
        LoginView()
    }
}
