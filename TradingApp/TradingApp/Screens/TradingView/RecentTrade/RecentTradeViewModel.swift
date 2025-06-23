//
//  RecentTradeViewModel.swift
//  TradingApp
//
//  Created by Duoc Do on 2/6/25.
//

import Combine
import Foundation

class RecentTradeViewModel: ObservableObject {
    @Published var recentTradeItems: [TradeItem] = []
    @Published var isLoading = false

    let webSocketService = WebSocketManager(urlStr: AppConfig.socketRealTimeURL)
    private let repo = TradeRepo()
    private let topics = ["trade:XBTUSD"]
    
    init() {
        webSocketService.connect()
        
        webSocketService.connection?.status = { [weak self] isConnected in
            guard let self = self else { return }
            if isConnected {
                Task {
                    do {
                        DispatchQueue.main.async {
                            self.isLoading = true
                        }
                        let tradeItems = try await self.repo.getLatestTrades(count: 30, symbol: "XBTUSD")
                        await self.appendTradeItems(newItems: tradeItems)
                        self.webSocketService.subscribe(topics: self.topics)
                    } catch {
                        print("Error fetching trades: \(error)")
                    }
                }
            }
        }
        
        webSocketService.didReceivedData = { [weak self] json in
            guard let self = self else { return }
            guard let orders = json["data"] as? [[String: Any]] else { return }
            
            DispatchQueue.main.async {
                var newItems: [TradeItem] = []
                
                for order in orders {
                    if let data = try? JSONSerialization.data(withJSONObject: order),
                       let item = try? JSONDecoder().decode(TradeItem.self, from: data) {
                        newItems.append(item)
                    }
                }
                
                self.appendTradeItems(newItems: newItems)
            }
        }
    }
    
    @MainActor
    private func appendTradeItems(newItems: [TradeItem]) {
        if isLoading {
            isLoading.toggle()
        }
        
        // prevent duplicate
        if recentTradeItems.count > 0 {
            for trade in newItems {
                if let index = recentTradeItems.firstIndex(where: {$0.uniqueKey == trade.uniqueKey}) {
                    recentTradeItems[index] = trade
                } else {
                    recentTradeItems.append(trade)
                }
            }
        } else {
            recentTradeItems.append(contentsOf: newItems)
        }
        
        // Sort
        recentTradeItems.sort(by: { $0.timestamp > $1.timestamp })
        
        // Show 30 latest trades
        recentTradeItems = Array(self.recentTradeItems.prefix(30))
    }
    
    deinit {
        webSocketService.disconnect()
        webSocketService.unSubscribe(topics: topics)
    }
}
