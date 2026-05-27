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
                .foregroundStyle(.blue)
            Text(label)
                .font(.subheadline)
            Text(value)
                .font(.subheadline.bold())
                .multilineTextAlignment(.center)
        }
        .padding()
        .frame(maxWidth: 150, maxHeight: 150)
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 24))

    }
}
