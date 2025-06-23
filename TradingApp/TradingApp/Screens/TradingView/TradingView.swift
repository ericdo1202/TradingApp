//
//  TradingView.swift
//  TradingApp
//
//  Created by Duoc Do on 2/6/25.
//

import SwiftUI

// MARK: Properties Wrapper
struct TradingView {
    @State private var selectedTab: Tab = .orderBook // default is order book tab
}

// MARK: Body View
extension TradingView: View {
    var body: some View {
        NavigationStack {
            VStack {
                // Tab bar
                CustomTabBar(selectedTab: $selectedTab)

                // i added them inside the tabview to prevent reload many time when click on tab item
                TabView(selection: $selectedTab) {
                    OrderBookView()
                        .tag(Tab.orderBook)
                        .id("\(OrderBookView.self)")
                    RecentTradeView()
                        .tag(Tab.recentTrade)
                        .id("\(RecentTradeView.self)")
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
                
            }
            .background(AppColors.white)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                
                // Title
                ToolbarItem(placement: .principal) {
                    Text("XBTUSD.PERF")
                        .font(AppFonts.bold(size: .H4))
                        .foregroundStyle(AppColors.neutral900)
                }
            }
        }
    }
}

struct CustomTabBar: View {
    @Binding var selectedTab: Tab
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(Tab.allCases, id: \.self) { tab in
                Button(action: {
                    selectedTab = tab
                }) {
                    VStack(spacing: 16) {
                        Text(tab.title)
                            .font(AppFonts.semiBold(size: .H5))
                            .foregroundStyle(tab == selectedTab ? AppColors.neutral600 : AppColors.neutral300)
                        Rectangle()
                            .fill(selectedTab == tab ? AppColors.secondary950 : AppColors.neutral100)
                            .frame(height: 2)
                        
                    }
                }
            }
        }
        .padding(.top, 16)
    }
}

#Preview {
    TradingView()
}
