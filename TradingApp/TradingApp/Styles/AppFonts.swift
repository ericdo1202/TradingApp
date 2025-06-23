//
//  AppFonts.swift
//  TradingApp
//
//  Created by Duoc Do on 2/6/25.
//

import SwiftUI

enum AppFontSizes: CGFloat {
    case H1 = 26
    case H2 = 22
    case H3 = 18
    case H4 = 16
    case H5 = 14
    case H6 = 11

}

struct AppFonts {
    static func bold(size: AppFontSizes) -> Font {
        return .custom("Inter-Bold", size: size.rawValue)
    }

    static func medium(size: AppFontSizes) -> Font {
        return .custom("Inter-Medium", size: size.rawValue)
    }

    static func regular(size: AppFontSizes) -> Font {
        return .custom("Inter-Regular", size: size.rawValue)
    }

    static func semiBold(size: AppFontSizes) -> Font {
        return .custom("Inter-SemiBold", size: size.rawValue)
    }
}

