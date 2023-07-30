//
//  DateExtension.swift
//  ColorBookMarkV2
//
//  Created by SUN on 2023/04/23.
//

import Foundation

extension Date {
    
    /// Date 타입을 이용해서 원하는 포맷의 string으로 반환하는 함수
    /// - Parameters:
    ///   - format: 반환하고 싶은 포맷. ex) yyyyMMdd
    ///   - locale: 시간을 측정할 위치
    ///   - timeZone: 타임존
    /// - Returns: format인자 형태로 반환
   func toString(format: String, locale: String? = nil, timeZone: String? = nil) -> String {
        let dateFormatter: DateFormatter = DateFormatter()
        dateFormatter.locale = locale == nil ? Locale(identifier: "ko_KR") : Locale(identifier: locale!)
        dateFormatter.timeZone = timeZone == nil ? nil : TimeZone(abbreviation: timeZone!.uppercased())
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
    
    var startOfMonth: Date {
        let gregorian = Calendar(identifier: .gregorian)
        let tmpDay = gregorian.date(from: gregorian.dateComponents([.year, .month], from: self))
        return gregorian.date(byAdding: .day, value: 0, to: tmpDay!)!
    }
    
    var endOfMonth: Date {
        let gregorian = Calendar(identifier: .gregorian)
        var tmpDay = gregorian.date(from: gregorian.dateComponents([.year, .month], from: self))
        tmpDay = gregorian.date(byAdding: .month, value: 1, to: tmpDay!)
        return gregorian.date(byAdding: .day, value: -1, to: tmpDay!)!
    }
    
    // 달에 있는 일 수
    var numberOfDaysInMonth: Int {
        return Calendar.current.range(of: .day, in: .month, for: self)?.count ?? 0
    }
    
    // 해당 월 시작 요일
    var weekday: Int {
        return Calendar.current.component(.weekday, from: self)
    }
    
}
