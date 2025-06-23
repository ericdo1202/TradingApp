//
//  WebSocketHandleData.swift
//  TradingApp
//
//  Created by Duoc Do on 3/6/25.
//

import Foundation

class WebSocketHandleData {
    func parseStringToJson(_ string: String) -> [String:Any] {
        if let data = string.data(using: .utf8), let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any] {
            return json
        }
        return [:]
    }
}
