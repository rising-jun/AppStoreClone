//
//  CellInfo.swift
//  AppStoreClone
//
//  Created by 김동준 on 2022/08/15.
//

import Foundation

enum InfoSequence: Int {
    case provider
    case reviewRating
    case appSize
    case category
    case surpportDevice
}
extension InfoSequence {
    var title: String {
        switch self {
        case .provider:
            return "제공"
        case .reviewRating:
            return "평점"
        case .appSize:
            return "크기"
        case .category:
            return "카테고리"
        case .surpportDevice:
            return "호환성"
        }
    }
    
    var value: Int {
        return self.rawValue
    }
}

enum DetailSection: Int {
    case title
    case newFeature
    case preview
    case description
    case info
}
extension DetailSection {
    var value: Int {
        return rawValue
    }
    static let numberOfSection: Int = 5
}
