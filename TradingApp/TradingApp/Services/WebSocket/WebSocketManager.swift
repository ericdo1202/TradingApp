//
//  WebSocketManager.swift
//  TradingApp
//
//  Created by Duoc Do on 2/6/25.
//

import Combine
import Starscream
import Foundation

class WebSocketManager {
    private var socket: WebSocket?
    private var subcribe: WebSocketSubcribe?
    private let handleData = WebSocketHandleData()
    
    var connection: WebSocketConnection?
    var didReceivedData: ((_ json: [String : Any ]) -> Void )?
    
    init(urlStr: String) {
        if let url = URL(string: urlStr) {
            let requestUrl = URLRequest(url: url)
            socket = WebSocket(request: requestUrl)
            connection = WebSocketConnection(socket: socket)
            subcribe = WebSocketSubcribe(socket: socket)
            socket?.delegate = self
        }
    }
    
    func unSubscribe(topics: [String]) {
        subcribe?.unSubscribe(topics: topics)
    }
    
    func subscribe(topics: [String]) {
        subcribe?.subscribe(topics: topics)
    }
    
    func connect() {
        connection?.connect()
    }
    
    func disconnect() {
        connection?.disconnect()
    }
    
}

// MARK: WebSocketDelegate
extension WebSocketManager: WebSocketDelegate {
    func didReceive(event: WebSocketEvent, client: WebSocketClient) {
        switch event {
        case .connected(let headers):
            connection?.updateConnectionStatus(isConnected: true)
            print("websocket is connected: \(headers)")
        case .disconnected(let reason, let code):
            connection?.updateConnectionStatus(isConnected: false)
            print("websocket is disconnected: \(reason) with code: \(code)")
        case .text(let string):
            let json = handleData.parseStringToJson(string)
            didReceivedData?(json)
        case .binary(let data):
            print("Received data: \(data.count)")
        case .ping(_):
            break
        case .pong(_):
            break
        case .viabilityChanged(_):
            break
        case .reconnectSuggested(_):
            break
        case .cancelled:
            connection?.updateConnectionStatus(isConnected: false)
        case .error(_):
            connection?.updateConnectionStatus(isConnected: false)
        case .peerClosed:
            break
        }
    }
    
}
