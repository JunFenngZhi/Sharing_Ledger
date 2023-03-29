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
