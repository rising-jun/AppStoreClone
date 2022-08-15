//
//  DateManager.swift
//  AppStoreClone
//
//  Created by 김동준 on 2022/08/12.
//

import Foundation

struct DateManager {
    private let yearIndex = 0
    private let monthIndex = 1
    private let dayIndex = 2
    
    func findDateGap(date: String) -> String {
        let startIndex = date.index(date.startIndex, offsetBy: 0)
        let endIndex = date.index(date.startIndex, offsetBy: 10)
        let dateInfo = date[startIndex ..< endIndex].components(separatedBy: "-")
        let nowDateComponent = DateComponents(year: Int(dateInfo[yearIndex]) ?? 0,
                                              month: Int(dateInfo[monthIndex]) ?? 0,
                                              day: Int(dateInfo[dayIndex]) ?? 0)
        guard let startDate = Calendar.current.date(from: nowDateComponent) else { return "" }
        let offsetComps = Calendar.current.dateComponents([.year,.month,.day], from: startDate, to: Date())
        if case let (y?, m?, d?) = (offsetComps.year, offsetComps.month, offsetComps.day) {
            if y > 0 {
                return "\(y)년"
            }
            if m > 0 {
                return "\(m)달"
            }
            if d > 0 {
                return "\(d)일"
            }
        }
        return ""
    }
}
