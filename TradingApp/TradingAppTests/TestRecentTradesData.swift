//
//  TestRecentTradesData.swift
//  TradingAppTests
//
//  Created by Duoc Do on 2/6/25.
//

import XCTest

final class TestRecentTradesData: XCTestCase {
    
    let viewModel = RecentTradeViewModel()
    
    override func setUp() {
        super.setUp()
    }
    
    
    func testGet30LatestTrades() {
        let mockData: [String: Any] = [
            "data": (1...30).map { i in
                [
                    "price": 100.0 + Double(i),
                    "size": i * 10,
                    "side": "Sell",
                    "timestamp":""
                ]
            }
        ]
        
        viewModel.webSocketService.didReceivedData?(mockData)
        let expectation = XCTestExpectation(description: "Trade order should be updated")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
            XCTAssertTrue(self.viewModel.recentTradeItems.count == 30 )
            expectation.fulfill()
        })
        
        wait(for: [expectation], timeout: 1)
    }
    
    func testGet30LatestTradesFromBritmex() {
        // the fetch data function is automatically running when viewmodel is initialized
        let expectation = XCTestExpectation(description: "Trade order should be updated")
        DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
            XCTAssertTrue(self.viewModel.recentTradeItems.count == 30 )
            expectation.fulfill()
        })
        
        wait(for: [expectation], timeout: 4)
    }
    
}
