//
//  Date.swift
//  BBKit
//
//  Created by lk on 2023/2/17.
//

import Foundation

public enum BBFormatterType : String {
    case ymdhms = "yyyy-MM-dd HH:mm:ss"
    case ymd = "yyyy-MM-dd"
}

public extension Date {
    
    /// 获取当前 秒级 时间戳 - 10位
    var timeStamp : Int {
        let timeInterval: TimeInterval = self.timeIntervalSince1970
        let timeStamp = Int(timeInterval)
        return timeStamp
    }
    /// 获取当前 毫秒级 时间戳 - 13位
   var milliStamp : Double {
       let timeInterval: TimeInterval = self.timeIntervalSince1970
       let millisecond = Double(round(timeInterval*1000))
       return millisecond
   }
    
    static func getDateWith(timeStamp: Int) -> Date {
      let date = Date(timeIntervalSince1970: TimeInterval.init(timeStamp))
      return date
    }
    
    // 获取这个月有多少天
    func getMonthHowManyDay() -> Int? {
        return NSCalendar.current.range(of: .day, in: .month, for: self)?.count
    }
    
    /// 今天的日期
    var todayDate: Date {
        return Date()
    }
    
    var todayString: String {
        return todayDate.dateToString()
    }
    
    // MARK: 3.2、昨天的日期
    /// 昨天的日期
    var yesterDayDate: Date? {
        return adding(day: -1)
    }
    
    /// 日期的加减操作
     /// - Parameter day: 天数变化
     /// - Returns: date
     private func adding(day: Int) -> Date? {
         return Calendar.current.date(byAdding: DateComponents(day:day), to: self)
     }
    
    // MARK: 2.1、时间戳 按照对应的格式 转化为 对应时间的字符串，支持10位 和 13位
    /// 时间戳 按照对应的格式 转化为 对应时间的字符串，支持10位 和 13位 如：1603849053 按照 "yyyy-MM-dd HH:mm:ss" 转化后为：2020-10-28 09:37:33
    /// - Parameters:
    ///   - timestamp: 时间戳
    ///   - format: 格式
    /// - Returns: 对应时间的字符串
    static func timestampToFormatterTimeString(timestamp: String, format: String = "yyyy-MM-dd HH:mm:ss") -> String {
        // 时间戳转为Date
        let date = timestampToFormatterDate(timestamp: timestamp)
        let dateFormatter = DateFormatter()
        // 设置 dateFormat
        dateFormatter.dateFormat = format
        // 按照dateFormat把Date转化为String
        return dateFormatter.string(from: date)
    }
    // MARK: 2.2、时间戳 转 Date, 支持 10 位 和 13 位
    /// 时间戳 转 Date, 支持 10 位 和 13 位
    /// - Parameter timestamp: 时间戳
    /// - Returns: 返回 Date
    static func timestampToFormatterDate(timestamp: String) -> Date {
        guard timestamp.count == 10 ||  timestamp.count == 13 else {
            #if DEBUG
            fatalError("时间戳位数不是 10 也不是 13")
            #else
            return Date()
            #endif
        }
        let timestampValue = timestamp.count == 10 ? Double(timestamp).unwraps : Double(timestamp).unwraps / 1000
        // 时间戳转为Date
        let date = Date(timeIntervalSince1970: timestampValue)
        return date
    }

    /// 日期  转 日期字符串 formatSrt -> yyyy/MM/dd  yyyy-MM-dd  yyyy-MM-dd HH:mm  yyyy-MM-dd HH:mm:ss  yyyy-MM-dd HH:mm:ss SSS * MM-dd HH:mm MM.dd HH:mm
    func dateToString(_ formatter: BBFormatterType = .ymd) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = formatter.rawValue
        dateFormatter.timeZone = TimeZone.autoupdatingCurrent
        dateFormatter.dateFormat = formatter.rawValue
        return dateFormatter.string(from: self)
    }

    /// 时间字符串  转 日期  formatSrt -> yyyy/MM/dd  yyyy-MM-dd  yyyy-MM-dd HH:mm  yyyy-MM-dd HH:mm:ss  yyyy-MM-dd HH:mm:ss SSS * MM-dd HH:mm MM.dd HH:mm
    /// dateStr -> "2021-06-22 12:00:00"
    static func date(formatterString: BBFormatterType = .ymd, dateString: String?) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = NSTimeZone(abbreviation: "UTC") as TimeZone?
        dateFormatter.dateFormat = formatterString.rawValue
        let date = dateFormatter.date(from: dateString ?? "")
        if let date = date {
            return date
        } else {
            return Date()
        }
    }
    
    /// 获取 某天是 星期几 1->星期日 2->星期一 3 ->星期二 4->星期三 5->星期四 6->星期五 7->星期六
    func dayOfweek() -> Int {
        let gregorian = Calendar(identifier: .gregorian)
        let comps = gregorian.dateComponents([.day, .month, .year, .weekday], from: self)
        let weekday = comps.weekday ?? 0
        return weekday
    }
    
    func isToday() -> Bool {
        return self.isSameDay()
    }
    
    func isSameDay(_ anotherDate: Date? = Date()) -> Bool {
        let calendar = Calendar.current
        let components1 = Calendar.current.dateComponents([.year, .month, .day],from: self)
        let components2 = calendar.dateComponents([.year, .month, .day],from: anotherDate!)
        return components1.year == components2.year && components1.month == components2.month && components1.day == components2.day
    }
    
    /// 公历转农历
    func solarToLunar() -> String {
        let calendar = Calendar(identifier: Calendar.current.identifier)
        
        //初始化公历日历
        let solarCalendar = Calendar.init(identifier: .gregorian)
        var components = DateComponents()
        components.year = calendar.component(.year, from: self)
        components.month = calendar.component(.month, from: self)
        components.day = calendar.component(.day, from: self)
        components.hour = 12
        components.minute = 0
        components.second = 0
        components.timeZone = TimeZone.init(secondsFromGMT: 60 * 60 * 8)
        let solarDate = solarCalendar.date(from: components)
         
        //初始化农历日历
        let lunarCalendar = Calendar.init(identifier: .chinese)
        //日期格式和输出
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "zh_CN")
        formatter.dateStyle = .medium
        formatter.calendar = lunarCalendar
        return formatter.string(from: solarDate!)
    }
}
