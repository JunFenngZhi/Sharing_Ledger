//
//  PersonDict.swift
//  SharingLedger
//
//  Created by mac on 2023/3/26.
//

import Foundation

class PersonDetail: Identifiable, Hashable, Codable {
    var id: String //capture firestore id
    var lastname: String
    var firstname: String
    var joinedEventNames: [String] // store the event ID
    var picture: String
    
    init(id: String, lname: String, fname: String, joinedEventNames: [String]){
        self.id = id
        self.lastname = lname
        self.firstname = fname
        self.picture = base64pic("Unknown")!

        self.joinedEventNames = joinedEventNames
    }
    
    // Conform to the Hashable protocol by providing a hash(into:) method
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
//        hasher.combine(lastname)
//        hasher.combine(firstname)
//        hasher.combine(joinedEventNames)
    }
    
    // Conform to the Equatable protocol by providing an == operator
    static func == (lhs: PersonDetail, rhs: PersonDetail) -> Bool {
        return lhs.id == rhs.id && lhs.lastname == rhs.lastname && lhs.firstname == rhs.firstname && lhs.joinedEventNames == rhs.joinedEventNames
    }
}

class PersonDict {
    //the key of dict is the name of person, firstname + " " + lastname
    //the value of dict is PersonDetail
    var personDict: [String: PersonDetail] = [:]
}
