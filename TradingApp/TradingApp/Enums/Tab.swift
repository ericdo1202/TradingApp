//
//  TabView.swift
//  TradingApp
//
//  Created by Duoc Do on 2/6/25.
//

import SwiftUI

enum Tab: String, CaseIterable, Equatable {
    case orderBook = "OrderBook"
    case recentTrade = "RecentTrade"
    
    var title: String {
        switch self {
        case .orderBook:
            return Localize.order_book()
        case .recentTrade:
            return Localize.recent_trades()
        }
    }
}
