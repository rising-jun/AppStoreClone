//
//  AppStoreAPI.swift
//  AppStoreClone
//
//  Created by 김동준 on 2022/08/11.
//

import Foundation

enum AppStoreAPI: BaseAPI {
    static var baseURL = "http://itunes.apple.com/lookup"
    
    case search(id: String)
    
    var url: URL? {
        switch self{
        case .search(let id):
            return URL(string: Self.baseURL + "?id=\(id)")
        }
    }
    
    var method: String {
        switch self{
        case .search:
            return "GET"
        }
    }
}

protocol BaseAPI {
    static var baseURL: String { get set }
    var url: URL? { get }
    var method: String { get }
}
