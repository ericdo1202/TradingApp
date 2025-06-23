//
//  TestWebSocket.swift
//  TradingAppTests
//
//  Created by Duoc Do on 2/6/25.
//

import XCTest

final class TestOrderBookData: XCTestCase {
    
    let viewModel = OrderBookViewModel()
    
    override func setUp() {
        super.setUp()
    }
    
    func testGetBuyAndSellItemsFromBritmex() {
        //the fetch data function is automatically running when viewmodel is initialized
        
        let expectation = XCTestExpectation(description: "Buy and sell order should be updated from britmex")
        DispatchQueue.main.asyncAfter(deadline: .now() + 5, execute: {
            XCTAssertTrue(self.viewModel.buyOrders.count > 0)
            XCTAssertTrue(self.viewModel.sellOrders.count > 0)
            expectation.fulfill()
        })
        
        wait(for: [expectation], timeout: 10)
    }
    
    func testGet20BuyItems() {
        let mockData: [String: Any] = [
            "data": (1...20).map { i in
                [
                    "price": 100.0 + Double(i),
                    "size": i * 10,
                    "side": "Buy",
                    "timestamp":""
                ]
            }
        ]
        
        viewModel.service.didReceivedData?(mockData)
        let expectation = XCTestExpectation(description: "Buy order should be updated")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
            XCTAssertEqual(self.viewModel.buyOrders.count, 20)
            expectation.fulfill()
        })
        
        wait(for: [expectation], timeout: 1)
    }
    
    func testBuyItemsOrderDescending() {
        let mockData: [String: Any] = [
            "data": (1...20).map { i in
                [
                    "price": 100.0 + Double(i),
                    "size": i * 10,
                    "side": "Buy",
                    "timestamp":""
                ]
            }
        ]
        
        viewModel.service.didReceivedData?(mockData)
        let expectation = XCTestExpectation(description: "Buy order should be sort descending")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
            let prices = self.viewModel.buyOrders.map { $0.price }
            let sortedPrices = prices.sorted(by: >)
            XCTAssertEqual(prices, sortedPrices, "Buy orders should be sorted descending by price")
            expectation.fulfill()
        })
        
        wait(for: [expectation], timeout: 1)
    }
    
    func testGet20SellItems() {
        let mockData: [String: Any] = [
            "data": (1...20).map { i in
                [
                    "price": 100.0 + Double(i),
                    "size": i * 10,
                    "side": "Sell",
                    "timestamp":""
                ]
            }
        ]
        
        viewModel.service.didReceivedData?(mockData)
        let expectation = XCTestExpectation(description: "Buy order should be updated")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
            XCTAssertEqual(self.viewModel.sellOrders.count, 20)
            expectation.fulfill()
        })
        
        wait(for: [expectation], timeout: 1)
    }
    
    func testSellItemsOrderAscending() {
        let mockData: [String: Any] = [
            "data": (1...20).map { i in
                [
                    "price": 100.0 + Double(i),
                    "size": i * 10,
                    "side": "Sell",
                    "timestamp":""
                ]
            }
        ]
        
        viewModel.service.didReceivedData?(mockData)
        let expectation = XCTestExpectation(description: "Sell order should be sort Ascending")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
            let prices = self.viewModel.buyOrders.map { $0.price }
            let sortedPrices = prices.sorted(by: <)
            XCTAssertEqual(prices, sortedPrices, "Sell orders should be sorted Ascending by price")
            expectation.fulfill()
        })
        
        wait(for: [expectation], timeout: 1)
    }
    
}
