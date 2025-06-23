//
//  WebSocketConnection.swift
//  TradingApp
//
//  Created by Duoc Do on 2/6/25.
//

import Starscream
typealias WebSocketConnectionStatus = (_ isConnected: Bool) -> Void
protocol WebSocketConnectionProtocol {
    func connect()
    func disconnect()
    func retryConnect()
    func updateConnectionStatus(isConnected: Bool)
}

class WebSocketConnection: WebSocketConnectionProtocol {
    private var socket: WebSocket?
    var isConnected = false
    var status: WebSocketConnectionStatus = { _ in }
    
    init(socket: WebSocket?) {
        self.socket = socket
    }
    
    func connect() {
        socket?.connect()
        
    }
    
    func disconnect() {
        socket?.disconnect()
    }
    
    func updateConnectionStatus(isConnected: Bool) {
        self.isConnected = isConnected
        status(isConnected)
    }
    
    func retryConnect() {
        // TODO: retry when disconnected
    }
    
}
