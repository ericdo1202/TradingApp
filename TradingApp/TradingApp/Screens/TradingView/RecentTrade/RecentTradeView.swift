//
//  RecentTradeView.swift
//  TradingApp
//
//  Created by Duoc Do on 2/6/25.
//

import SwiftUI

// MARK: Properties Wrapper
struct RecentTradeView {
    @StateObject private var viewModel: RecentTradeViewModel
    
    init(viewModel: RecentTradeViewModel = RecentTradeViewModel()) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
}

// MARK: Body View
extension RecentTradeView: View {
    var body: some View {
        ScrollView {
            if viewModel.isLoading {
                LoadingView()
                    .padding(16)
            }
            // Header
            Text(Localize.recent_trades())
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(AppFonts.bold(size: .H3))
                .foregroundStyle(AppColors.neutral600)
                .padding(.horizontal, 16)
            Divider()

            HStack {
                Text(Localize.price())
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(AppFonts.medium(size: .H5))
                    .foregroundStyle(AppColors.neutral500)
                
                Text(Localize.qty())
                    .frame(maxWidth: .infinity, alignment: .center)
                    .font(AppFonts.medium(size: .H5))
                    .foregroundStyle(AppColors.neutral500)
                
                Text(Localize.time())
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .font(AppFonts.medium(size: .H5))
                    .foregroundStyle(AppColors.neutral500)
            }
            .padding(.horizontal, 16)
            Divider()
            
            // Data view
            VStack(spacing: 0){
                ForEach(viewModel.recentTradeItems, id: \.id) { item in
                    RecentTradeRowView(tradeItem: item)
                }
            }
            .padding(.horizontal, 16)
        }
    }
}

#Preview {
    RecentTradeView()
}
