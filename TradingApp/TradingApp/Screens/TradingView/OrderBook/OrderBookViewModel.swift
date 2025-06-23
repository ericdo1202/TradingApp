import Combine
import Foundation

class OrderBookViewModel: ObservableObject {
    @Published var buyOrders: [OrderBookItem] = []
    @Published var sellOrders: [OrderBookItem] = []
    @Published var buyMaxAccumulatedSize = 0
    @Published var sellMaxAccumulatedSize = 0
    @Published var isLoading = false

    let service = WebSocketManager(urlStr: AppConfig.socketRealTimeURL)
    private let topics = ["orderBookL2:XBTUSD"]
    
    init() {
        service.connect()
        
        service.connection?.status = { [weak self] isConnected in
            guard let self = self else { return }
            if isConnected {
                DispatchQueue.main.async {
                    self.isLoading = true
                }
                self.service.subscribe(topics: topics)
            }
        }
        
        service.didReceivedData = { [weak self] json in
            guard let self = self else { return }
            guard let orders = json["data"] as? [[String: Any]] else { return }

            DispatchQueue.main.async {
                if self.isLoading {
                    self.isLoading.toggle()
                }
                for order in orders {
                    guard let data = try? JSONSerialization.data(withJSONObject: order),
                          let item = try? JSONDecoder().decode(OrderBookItem.self, from: data) else { continue }

                    if item.isBuy {
                        self.update(&self.buyOrders, with: item, descending: true)
                        self.updateCumulativeVolumes(list: &self.buyOrders, isBuy: true)
                    } else if item.isSell {
                        self.update(&self.sellOrders, with: item, descending: false)
                        self.updateCumulativeVolumes(list: &self.sellOrders, isBuy: false)
                    }
                }
            }
        }
    }

    private func update(_ list: inout [OrderBookItem], with newItem: OrderBookItem, descending: Bool) {
        
        if let index = list.firstIndex(where: { $0.price == newItem.price }) {
            if newItem.size == 0 {
                list.remove(at: index)
            } else {
                list[index] = newItem
            }
        } else {
            if newItem.size > 0 {
                list.append(newItem)
            }
        }
        
        list.sort { descending ? $0.price > $1.price : $0.price < $1.price }
        if list.count > 20 {
            list = Array(list.prefix(20))
        }
    }
    
    private func updateCumulativeVolumes(list: inout [OrderBookItem], isBuy: Bool) {
        var accumulated = 0
        var maxVolume = 0

        for i in 0..<list.count {
            accumulated += list[i].size
            list[i].volumeOfAccumulated = accumulated
            maxVolume = max(maxVolume, accumulated)
        }
        
        if isBuy {
            buyMaxAccumulatedSize = maxVolume
        } else {
            sellMaxAccumulatedSize = maxVolume
        }
    }
    
    deinit {
        service.disconnect()
        service.unSubscribe(topics: topics)
    }
}
