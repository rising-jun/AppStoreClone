//
//  StringManager.swift
//  AppStoreClone
//
//  Created by 김동준 on 2022/08/15.
//

import Foundation

struct StringManager { }
extension StringManager: StringManagable {
    func stringAppender(strings: [String]) -> String {
        var result = ""
        for string in strings {
            result += "\(string)\n"
        }
        return result
    }
}
protocol StringManagable {
    func stringAppender(strings: [String]) -> String
}
