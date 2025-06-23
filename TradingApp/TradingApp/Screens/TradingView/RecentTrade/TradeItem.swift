//
//  TradeItem.swift
//  TradingApp
//
//  Created by Duoc Do on 2/6/25.
//

import Foundation

struct TradeItem: OrderItemProtocol, Decodable {
    var id: String = NSUUID().uuidString
    let price: Double
    let size: Int
    let side: String
    let timestamp: String
    
    // Create unique key to prevent duplicate data from both socket and restful api
    var uniqueKey: String {
        return "\(timestamp)_\(price)_\(size)_\(side)"
    }
    
    enum CodingKeys: String, CodingKey {
        case price
        case size
        case side
        case timestamp
    }
}
