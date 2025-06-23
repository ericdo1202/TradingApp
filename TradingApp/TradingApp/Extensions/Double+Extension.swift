//
//  Double+Extension.swift
//  TradingApp
//
//  Created by Duoc Do on 3/6/25.
//

import Foundation

extension Double {
    func formattedPrice() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.locale = Locale(identifier: "en_US") // force comma as separator
        formatter.minimumFractionDigits = 1
        formatter.maximumFractionDigits = 1
        return formatter.string(from: NSNumber(value: self)) ?? "\(self)"
    }
}
