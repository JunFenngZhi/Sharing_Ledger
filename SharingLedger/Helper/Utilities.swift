//
//  Utilities.swift
//  SharingLedger
//
//  Created by mac on 2023/3/29.
//

import Foundation
import UIKit

let defaultPhoto = UIImage(named: "Unknown")

func getDocumentsDirectory() -> URL {
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    let documentsDirectory = paths[0]
    return documentsDirectory
}

func imageFromString(_ strPic: String) -> UIImage {
    if (strPic.count < 4){
        return defaultPhoto!
    }
    var picImage: UIImage?
    if (String(strPic.prefix(4)) == "/9j/") {
        let picImageData = Data(base64Encoded: strPic, options: .ignoreUnknownCharacters)
        picImage = UIImage(data: picImageData!)
    } else {
        picImage = defaultPhoto
    }
    return picImage!
}

func stringFromImage(_ imagePic: UIImage) -> String {
    let picImageData: Data = imagePic.jpegData(compressionQuality: 0.5)!
    let picBase64 = picImageData.base64EncodedString()
    return picBase64
}

func base64pic(_ imageName: String) -> String? {
    var base64String: String?
    if let picImage = UIImage(named: imageName) {
        base64String = stringFromImage(picImage)
    }
    return base64String
}

func isZero_Double(num: Double) -> Bool{
    let tolerance = 0.000001
    if(abs(num) > tolerance){
        return false;
    }
    return true
}

func printDate(date: Date) -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    let dateString = formatter.string(from: Date())
    return dateString
}

func StringToDate(date: String) -> Date {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    let dateString = date
    if let date = dateFormatter.date(from: dateString) {
        return date
    } else {
        return Date()
    }
}
