//
//  OrderBookRowView.swift
//  TradingApp
//
//  Created by Duoc Do on 2/6/25.
//

import SwiftUI

// MARK: Properties wrapper
struct OrderBookRow {
    var order: OrderBookItem
    var color: Color
    var backgroundColor: Color
    var maxSize: Int
    var isReversed: Bool = false // default is false
}

// MARK: Body view
extension OrderBookRow: View {
    
    var body: some View {
        GeometryReader { geo in
            
            // Bar color
            let barHeight = 40.0
            let fraction = maxSize > 0 ? CGFloat(order.volumeOfAccumulated) / CGFloat(maxSize) : 0
            let barWidth = geo.size.width * fraction

            ZStack{
                HStack(spacing: 0){
                    Color.clear
                        .frame(height: barHeight)
                        .frame(maxWidth: .infinity)
                    backgroundColor
                        .frame(width: barWidth, height: barHeight)
                }
            }
            .frame(maxHeight: .infinity)
            .environment(\.layoutDirection, isReversed ? .rightToLeft : .leftToRight)


            // Data
            HStack {
                Text(order.sizeStringFormat)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(AppFonts.semiBold(size: .H5))
                    .foregroundStyle(AppColors.neutral900)
                
                Text(order.priceStringFormat)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .font(AppFonts.semiBold(size: .H5))
                    .foregroundStyle(color)
                    .padding(.trailing, 16)
            }
            .frame(maxHeight: .infinity)
            .environment(\.layoutDirection, isReversed ? .rightToLeft : .leftToRight)
        }
        .frame(height: 40)
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    OrderBookRow(
        order: OrderBookItem(
            price: 1000,
            size: 200,
            side: ItemSide.buy.rawValue, 
            timestamp: ""
        ),
        color: AppColors.sell,
        backgroundColor: AppColors.sell_background,
        maxSize: 10,
        isReversed: false
    )
}
