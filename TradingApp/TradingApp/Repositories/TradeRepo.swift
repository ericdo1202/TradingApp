//
//  TradeRepo.swift
//  TradingApp
//
//  Created by Duoc Do on 3/6/25.
//

import Foundation
import Alamofire

class TradeRepo {
    func getLatestTrades(count: Int, symbol: String) async throws -> [TradeItem] {
        return try await withCheckedThrowingContinuation { continuation in
            let api = Api.APIName.getLatestTrades(count: count, symbol: symbol)
            AF.request(api.url, parameters: api.parameters)
                .validate()
                .responseDecodable(of: [TradeItem].self) { response in
                    switch response.result {
                    case .success(let trades):
                        continuation.resume(returning: trades)
                    case .failure(let error):
                        continuation.resume(throwing: error)
                    }
                }
        }
    }
}
