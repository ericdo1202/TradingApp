//
//  Int+Extension.swift
//  TradingApp
//
//  Created by Duoc Do on 3/6/25.
//

import Foundation

extension Int {
    func formattedWithSeparator() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = ","
        return formatter.string(from: NSNumber(value: self)) ?? "\(self)"
    }
}
