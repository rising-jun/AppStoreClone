//
//  DecimalManager.swift
//  AppStoreClone
//
//  Created by 김동준 on 2022/08/13.
//

import Foundation

struct DecimalManager {
    func convertReview(_ review: String) -> String{
        let startIndex = review.index(review.startIndex, offsetBy: 0)
        let endIndex = review.index(review.startIndex, offsetBy: 3)
        return String(review[startIndex ..< endIndex])
    }
    
    func convertAppSize(_ appSize: String) -> String {
        let startIndex = appSize.index(appSize.startIndex, offsetBy: 0)
        let endIndex = appSize.index(appSize.startIndex, offsetBy: 4)
        var replaceAppSize = String(appSize[startIndex ..< endIndex])
        replaceAppSize.insert(".", at: appSize.index(appSize.startIndex, offsetBy: 3))
        return replaceAppSize
    }
}
