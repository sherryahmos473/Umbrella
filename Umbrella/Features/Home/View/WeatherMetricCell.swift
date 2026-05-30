//
//  WeatherMetricCell.swift
//  Umbrella
//
//  Created by Sherry Ahmos on 27/05/2026.
//

import SwiftUI

struct WeatherMetricCell: View {
    let icon: String
    let label: String
    let value: String
    
    var body: some View {
        VStack(spacing: 6) {
            Image(systemName: icon)
                .resizable()
                .scaledToFit() 
                .frame(width: 30, height: 30)
                .foregroundStyle(.white)
            Text(label)
                .font(.subheadline)
                .foregroundStyle(.white)
            Text(value)
                .font(.subheadline.bold())
                .multilineTextAlignment(.center)
                .foregroundStyle(.white)
        }
        .padding()
        .frame(maxWidth: 150, maxHeight: 200)
        .background(
            RoundedRectangle(cornerRadius: 22)
                .fill(.white.opacity(0.12))
                .stroke(.white.opacity(0.18), lineWidth: 1)
        )
        .shadow(color: .black.opacity(0.12), radius: 10, y: 4)

    }
}
