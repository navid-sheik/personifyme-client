//
//  TimeManager.swift
//  PersonifyMe
//
//  Created by Navid Sheikh on 05/08/2023.
//

import Foundation


class TimeManager {
    static func timeAgo(from dateString: String) -> String {
        let dateFormatter = ISO8601DateFormatter()
        dateFormatter.formatOptions.insert(.withFractionalSeconds)
           

           guard let date = dateFormatter.date(from: dateString) else {
               return "Invalid date"
           }
        let calendar = Calendar.current
        let now = Date()
        let components = calendar.dateComponents([.year, .month, .weekOfYear, .day, .hour, .minute, .second], from: date, to: now)

        if let years = components.year, years >= 1 {
            return "\(years) year\(years > 1 ? "s" : "") ago"
        }

        if let months = components.month, months >= 1 {
            return "\(months) month\(months > 1 ? "s" : "") ago"
        }

        if let weeks = components.weekOfYear, weeks >= 1 {
            return "\(weeks) week\(weeks > 1 ? "s" : "") ago"
        }

        if let days = components.day, days >= 1 {
            return "\(days) day\(days > 1 ? "s" : "") ago"
        }

        if let hours = components.hour, hours >= 1 {
            return "\(hours) hour\(hours > 1 ? "s" : "") ago"
        }

        if let minutes = components.minute, minutes >= 1 {
            return "\(minutes) minute\(minutes > 1 ? "s" : "") ago"
        }

        if let seconds = components.second, seconds >= 3 {
            return "\(seconds) second\(seconds > 1 ? "s" : "") ago"
        }

        return "Just now"
    }
    static func orderDateFormatter(_ dateString: String) -> String {
           let isoFormatter = ISO8601DateFormatter()
           isoFormatter.formatOptions.insert(.withFractionalSeconds)

           guard let date = isoFormatter.date(from: dateString) else {
               return "Invalid date"
           }
           
           let dateFormatter = DateFormatter()
           dateFormatter.dateFormat = "MMM d, yyyy"
           
           return dateFormatter.string(from: date)
       }
    
    static func orderFormatterWithTime(_ dateString: String) -> String {
            let isoFormatter = ISO8601DateFormatter()
            isoFormatter.formatOptions = [.withFullDate, .withTime, .withColonSeparatorInTime, .withTimeZone, .withFractionalSeconds]
            
            guard let date = isoFormatter.date(from: dateString) else {
                return "Invalid date"
            }
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMM d, yyyy HH:mm"
            
            return dateFormatter.string(from: date)
        }
    
    
    static func openSinceYear(from dateString: String) -> String {
           let dateFormatter = ISO8601DateFormatter()
           dateFormatter.formatOptions.insert(.withFractionalSeconds)
           
           guard let date = dateFormatter.date(from: dateString) else {
               return "Invalid date"
           }
           
           let yearFormatter = DateFormatter()
           yearFormatter.dateFormat = "yyyy"
           
           let yearString = yearFormatter.string(from: date)
           return "Open since \(yearString)"
       }
}
