//
//  LoadingView.swift
//  TradingApp
//
//  Created by Duoc Do on 3/6/25.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        VStack {
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle())
                .scaleEffect(1.5) // optional, to make it bigger
            Text(Localize.loading())
                .font(AppFonts.medium(size: .H5))
                .foregroundStyle(AppColors.neutral900)
        }
    }
}
