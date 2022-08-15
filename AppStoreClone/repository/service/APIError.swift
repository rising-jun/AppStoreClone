//
//  APIError.swift
//  AppStoreClone
//
//  Created by 김동준 on 2022/08/15.
//

import Foundation

enum APIError: String, Error {
    case invalidURL = "유효하지 않은 URL."
    case notConnect = "연결되지 않음."
    case httpResponse = "HTTP Response 에러"
    case httpURLResponse = "URLResponse 에러"
    case nilData = "데이터 없음"
    case decode = "디코딩 에러"
}
extension APIError: CustomStringConvertible {
    var description: String {
        return rawValue
    }
}
