//
//  TradingAppApp.swift
//  TradingApp
//
//  Created by Duoc Do on 2/6/25.
//

import SwiftUI

@main
struct TradingAppApp: App {
    var body: some Scene {
        WindowGroup {
            if !isRunningTests {
                TradingView()
            }
        }
    }
    
    /// Detect if app is running inside a unit test target
    var isRunningTests: Bool {
        NSClassFromString("XCTest") != nil
    }
}
