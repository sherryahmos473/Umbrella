//
//  ForecastCell.swift
//  Umbrella
//
//  Created by Sherry Ahmos on 27/05/2026.
//

import SwiftUI

struct ForecastCell: View {
    let forecast: ForecastDay
    
    var body: some View {
        HStack {
            Text(forecast.date)
                .font(.body.bold())
            AsyncImage(url: URL(string: "https:\(forecast.day.condition.icon)")) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFit()
                case .failure:
                    Image(systemName: "cloud.sun.fill") 
                        .foregroundColor(.secondary)
                @unknown default:
                    EmptyView()
                }
            }
            .frame(width: 45, height: 45)
            Text(forecast.day.condition.text)
                .font(.system(.body, design: .rounded, weight: .semibold))
                .foregroundStyle(.secondary)
            
            HStack(spacing: 8) {
                    Text("\(Int(forecast.day.maxtempC))°")
                    .font(.system(.subheadline, design: .rounded, weight: .bold))
                        .foregroundStyle(.primary)
                        .monospacedDigit()
                    
                    Text("\(Int(forecast.day.mintempC))°")
                        .font(.system(.body, design: .rounded, weight: .semibold))
                        .foregroundStyle(.secondary)
                        .monospacedDigit()
                }
        }
        .padding()
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 16))
    }
}
