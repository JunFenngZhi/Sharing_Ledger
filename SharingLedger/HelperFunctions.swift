//
//  HelperFunctions.swift
//  SharingLedger
//
//  Created by Loaner on 4/12/23.
//

import Foundation


func isZero_Double(num: Double) -> Bool{
    let tolerance = 0.000001
    if(abs(num) > tolerance){
        return false;
    }
    return true
}
