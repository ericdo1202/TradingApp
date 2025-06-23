//
//  Date+Extension.swift
//  TradingApp
//
//  Created by Duoc Do on 3/6/25.
//

import Foundation

extension Date {
    static let dateFormat  = "HH:mm:ss"
    
    func toString(format: String) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
    
    static func getDate(dateString: String) -> Date? {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        return formatter.date(from: dateString)
    }
}
