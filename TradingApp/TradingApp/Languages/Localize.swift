//
//  Localize.swift
//  TradingApp
//
//  Created by Duoc Do on 2/6/25.
//

import Foundation

class Localize: LocalizeManager {
    class func order_book() -> String { return localizedStringForKey(key: "order_book") }
    class func recent_trades() -> String { return localizedStringForKey(key: "recent_trades") }
    class func price() -> String { return localizedStringForKey(key: "price") }
    class func qty() -> String { return localizedStringForKey(key: "qty") }
    class func total() -> String { return localizedStringForKey(key: "total") }
    class func time() -> String { return localizedStringForKey(key: "time") }
    class func loading() -> String { return localizedStringForKey(key: "loading") }
}
