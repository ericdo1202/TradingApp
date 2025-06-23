//
//  WebSocketSubcribe.swift
//  TradingApp
//
//  Created by Duoc Do on 2/6/25.
//

import Starscream
import Foundation

protocol WebSocketEventProtocol {
    func subscribe(topics: [String])
    func unSubscribe(topics: [String])
}

class WebSocketSubcribe: WebSocketEventProtocol {
    private var socket: WebSocket?
    
    init(socket: WebSocket? = nil) {
        self.socket = socket
    }
    
    func subscribe(topics: [String]) {
        let subscribeMsg = [
            "op": "subscribe",
            "args": topics
        ] as [String : Any]
        if let data = try? JSONSerialization.data(withJSONObject: subscribeMsg) {
            if let string = String(data: data, encoding: .utf8) {
                socket?.write(string: string)
            }
        }
    }
    
    func unSubscribe(topics: [String]) {
        let subscribeMsg = [
            "op": "unsubscribe",
            "args": topics
        ] as [String : Any]
        if let data = try? JSONSerialization.data(withJSONObject: subscribeMsg) {
            if let string = String(data: data, encoding: .utf8) {
                socket?.write(string: string)
            }
        }
    }
}
