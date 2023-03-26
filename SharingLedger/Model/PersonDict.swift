//
//  PersonDict.swift
//  SharingLedger
//
//  Created by mac on 2023/3/26.
//

import Foundation

class PersonDetail {
    var lastname: String
    var firstname: String
    var name: String
    var joinedEventNames: [String]
    
    init(lname: String, fname: String){
        self.lastname = lname
        self.firstname = fname
        self.name = fname + " " + lname
        self.joinedEventNames = []
    }
}

class PersonDict {
    //the key of dict is the name of person, firstname + " " + lastname
    //the value of dict is PersonDetail
    var personDict: [String: PersonDetail] = [:]
}
