//
//  Color+Extesion.swift
//  TradingApp
//
//  Created by Duoc Do on 2/6/25.
//

import SwiftUI

extension Color {
    init(hex: String) {
        let scanner = Scanner(string: hex)
        if hex.hasPrefix("#") {
            scanner.currentIndex = hex.index(after: hex.startIndex)
        }

        var hexNumber: UInt64 = 0
        if scanner.scanHexInt64(&hexNumber) {
            let r = Double((hexNumber & 0xFF0000) >> 16) / 255.0
            let g = Double((hexNumber & 0x00FF00) >> 8) / 255.0
            let b = Double(hexNumber & 0x0000FF) / 255.0
            self.init(red: r, green: g, blue: b)
            return
        }

        self.init(red: 0, green: 0, blue: 0)
    }
}
