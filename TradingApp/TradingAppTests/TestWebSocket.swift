//
//  TestWebSocket.swift
//  TradingAppTests
//
//  Created by Duoc Do on 2/6/25.
//

import XCTest

final class TestWebSocket: XCTestCase {
    private var service: WebSocketManager!
    
    override func setUp() {
        super.setUp()
        service = WebSocketManager(urlStr: AppConfig.socketRealTimeURL)
    }
    
    func testWebSocketConnection() {
        let expectation = self.expectation(description: "Web socket should connect")
        service.connect()
        
        service.connection?.status = { isConnected in
            if isConnected {
                expectation.fulfill()
            }
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testWebSocketDisConnection() {
        let expectation = self.expectation(description: "Web socket should disconnect")
        service.connect()
        
        service.connection?.status = { isConnected in
            if isConnected {
                self.service.disconnect()
                self.service.connection?.status = { isConnected in
                    if !isConnected {
                        expectation.fulfill()
                    }
                }
            }
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
}
