//
//  OrderBookView.swift
//  TradingApp
//
//  Created by Duoc Do
//

import SwiftUI

// MARK: Properties Wrapper
struct OrderBookView {
    @StateObject private var viewModel: OrderBookViewModel
    @State private var isAppear = false
    init(viewModel: OrderBookViewModel = OrderBookViewModel()) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
}

// MARK: Body View
extension OrderBookView: View {
    var body: some View {
        ScrollView {
            if viewModel.isLoading {
                LoadingView()
                    .padding(16)
            }
            VStack(spacing: 0) {
                // Header
                HStack {
                    // Quantity
                    Text(Localize.qty())
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(AppFonts.medium(size: .H5))
                        .foregroundStyle(AppColors.neutral500)
                    
                    // Price
                    Text(Localize.price())
                        .frame(maxWidth: .infinity, alignment: .center)
                        .font(AppFonts.medium(size: .H5))
                        .foregroundStyle(AppColors.neutral500)
                    
                    
                    // Quantity
                    Text(Localize.qty())
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .font(AppFonts.medium(size: .H5))
                        .foregroundStyle(AppColors.neutral500)
                }
                .padding(.horizontal, 16)
                .padding(.bottom, 8)
                Divider()
                
                // Data view
                HStack(spacing: 0){
                    // Buy items
                    VStack(spacing: 0){
                        ForEach(viewModel.buyOrders, id: \.id) { item in
                            OrderBookRow(
                                order: item,
                                color: AppColors.buy,
                                backgroundColor: AppColors.buy_background,
                                maxSize: viewModel.buyMaxAccumulatedSize
                            )
                        }
                    }
                    
                    // Sell items
                    VStack(spacing: 0){
                        ForEach(viewModel.sellOrders, id: \.id) { item in
                            OrderBookRow(
                                order: item,
                                color: AppColors.sell,
                                backgroundColor: AppColors.sell_background,
                                maxSize: viewModel.sellMaxAccumulatedSize,
                                isReversed: true
                            )
                        }
                    }
                    
                }
                .padding(.horizontal, 16)
            }
        }
    }
}


#Preview {
    OrderBookView()
}

