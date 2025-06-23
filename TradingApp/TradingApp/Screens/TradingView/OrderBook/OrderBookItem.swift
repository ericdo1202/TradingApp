//
//  OrderBookItem.swift
//  TradingApp
//
//  Created by Duoc Do on 2/6/25.
//

import Foundation

protocol OrderItemProtocol: Identifiable {
    var id: String { get } // some response from bitmex does not including id, so i defined them as an random string  from local for Identifiable
    var price: Double { get }
    var side: String { get }
    var size: Int { get }
    var isBuy: Bool { get }
    var timestamp: String { get }
}

extension OrderItemProtocol {
    var isBuy: Bool {
        return side.lowercased() == ItemSide.buy.rawValue
    }
    
    var isSell: Bool {
        return side.lowercased() == ItemSide.sell.rawValue
    }
    
    var priceStringFormat: String {
        return price.formattedPrice()
    }
    
    var sizeStringFormat: String {
        return size.formattedWithSeparator()
    }
}

struct OrderBookItem: OrderItemProtocol, Codable, Equatable {
    var id: String = NSUUID().uuidString
    let price: Double
    let size: Int
    let side: String
    let timestamp: String
    var volumeOfAccumulated: Int = 0
    
    enum CodingKeys: String, CodingKey {
        case price
        case size
        case side
        case timestamp
    }
}
