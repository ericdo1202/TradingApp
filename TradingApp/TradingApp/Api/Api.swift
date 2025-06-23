//
//  Api.swift
//  TradingApp
//
//  Created by Duoc Do on 3/6/25.
//

import Foundation
import Alamofire

extension String{
    var urlEncoding:String{
        return self.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? ""
    }
}

class Api {
    public static let sharedApi = Api()
    
    final class var baseUrl:String! {
        return AppConfig.britmexDomainApi
    }
    
    class var headers:HTTPHeaders{
        return [
            "Content-Type": "application/json",
            "Accept": "application/json",
        ]
    }
    
    enum APIName {
        case getLatestTrades(count: Int, symbol: String)
        
        var path: String {
            switch self {
            case .getLatestTrades:
                "v1/trade"
            }
        }
        
        var url: String {
            baseUrl + path
        }
        
        var parameters: [String:Any]? {
            var params:[String:Any] = [:]
            switch self {
            case .getLatestTrades(let count, let symbol):
                params = [
                    "symbol": symbol,
                    "count": count,
                    "reverse": true
                ]
            }
            return params
        }
        
        var httpMethod: HTTPMethod {
            switch self {
            default:
                return .get
            }
        }
    }
}
