//
//  RecentTradeRowView.swift
//  TradingApp
//
//  Created by Duoc Do on 2/6/25.
//

import SwiftUI

// MARK: Properties wrapper
struct RecentTradeRowView {
    let tradeItem: TradeItem
    @State private var isFlash = true
}

// MARK: Body view
extension RecentTradeRowView: View {
    var body: some View {
        HStack {
            // Price
            Text(tradeItem.priceStringFormat)
                .font(AppFonts.medium(size: .H5))
                .foregroundStyle(tradeItem.isBuy ? AppColors.buy : AppColors.sell)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            // size
            Text(tradeItem.sizeStringFormat)
                .font(AppFonts.medium(size: .H5))
                .foregroundStyle(tradeItem.isBuy ? AppColors.buy : AppColors.sell)
                .frame(maxWidth: .infinity, alignment: .center)
            
            // time
            Text(Date.getDate(dateString: tradeItem.timestamp)?.toString(format: Date.dateFormat) ?? "")
                .font(AppFonts.medium(size: .H5))
                .foregroundStyle(tradeItem.isBuy ? AppColors.buy : AppColors.sell)
                .frame(maxWidth: .infinity, alignment: .trailing)
        }
        .font(.system(size: 14, weight: .medium, design: .monospaced))
        .padding(.vertical, 2)
        .background((tradeItem.isBuy ? AppColors.buy : AppColors.sell).opacity(isFlash ? 0.2 : 0))
        .onAppear {
            withAnimation(.easeOut(duration: 0.2)) {
                isFlash = false
            }
        }
    }
}

#Preview {
    RecentTradeRowView(
        tradeItem: TradeItem(
            price: 1000,
            size: 200,
            side: ItemSide.buy.rawValue,
            timestamp: "18:40:17"
        )
    )
}
