//
//  DukePerson.swift
//  SharingLedger
//
//  Created by mac on 2023/3/29.
//

import Foundation

class DukePerson: Codable, ObservableObject{
    var netid: String
    var firstname: String
    var lastname: String
    var wherefrom: String
    var gender: Int //(NOTE: value of 0 = Unknown, 1 = Male, 2 = Female, 3 = Other)
    var role: String
    var team: String
    var movie: String
    var hobby: String
    var languages: [String]
    var email: String
    var picture: String
    //var dukeRole: DukeRole = DukeRole.Other
    
    init(netID: String) {
        self.netid = netID
        self.firstname = "N/A"
        self.lastname = "N/A"
        self.wherefrom = "N/A"
        self.gender = 0
        self.role = "Other"
        self.team = "N/A"
        self.movie = "N/A"
        self.hobby = "N/A"
        self.languages = []
        self.email = "N/A"
        self.picture = "N/A"
        
    }
}

extension DukePerson: CustomStringConvertible{
    var description: String {
        var str = firstname
        str.append(" ")
        str.append(lastname)
        str.append(" is from ")
        str.append(wherefrom)
        str.append(" and is a ")
        str.append(role)
        if gender==2 {
            str.append(". Her best programming ")
        } else {
            str.append(". His best programming ")
        }
        
        if (languages.count > 0) {
            if languages.count == 1 {
                str.append("language is ")
            } else {
                str.append("languages are ")
            }
            for i in 0..<languages.count {
                str.append(languages[i])
                if i == languages.count-1 {
                    str.append(". ")
                } else {
                    str.append(",")
                }
            }
        } else {
            str.append("language is ")
            str.append("N/A. ")
        }
        
        if gender==2 {
            str.append("Her favorite hobby is ")
        } else {
            str.append("His favorite hobby is ")
        }
        str.append(hobby)
        str.append(" and ")
        if gender==2 {
            str.append("her favorite movie is ")
        } else {
            str.append("his favorite movie is ")
        }
        str.append(movie)
        
        str.append(". You can reach ")
        if gender==2 {
            str.append("her ")
        } else {
            str.append("him ")
        }
        str.append("at " + netid + "@duke.edu.")
        return str
    }
    
    
}

extension DukePerson: Equatable{
    static func == (lhs: DukePerson, rhs: DukePerson) -> Bool {
        return lhs.netid == rhs.netid
    }
    
    
}
