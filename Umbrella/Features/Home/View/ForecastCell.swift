//
//  ForecastCell.swift
//  Umbrella
//
//  Created by Sherry Ahmos on 27/05/2026.
//

import SwiftUI

struct ForecastCell: View {
    var label: String
    var condition: String
    var icon: String
    var maxTemp: Int
    var minTemp: Int

    var body: some View {
        HStack(spacing: 16) {
            VStack(alignment: .leading, spacing: 4) {
                Text(label)
                    .font(.headline)
                    .fontWeight(.semibold)
                    .foregroundStyle(.white)

                Text(condition)
                    .font(.subheadline)
                    .foregroundStyle(.white.opacity(0.75))
                    .lineLimit(1)
            }

            Spacer()

            AsyncImage(url: URL(string: "https:\(icon)")) { phase in
                switch phase {

                case .success(let image):
                    image
                        .resizable()
                        .scaledToFit()

                case .failure(_):
                    Image(systemName: "cloud.sun.fill")
                        .resizable()
                        .scaledToFit()
                        .foregroundStyle(.yellow)

                default:
                    ProgressView()
                        .tint(.white)
                }
            }
            .frame(width: 42, height: 42)

            VStack(alignment: .trailing, spacing: 2) {

                Text("\(maxTemp)°")
                    .font(.title3.bold())
                    .foregroundStyle(.white)
                    .monospacedDigit()

                Text("\(minTemp)°")
                    .font(.subheadline)
                    .foregroundStyle(.white.opacity(0.7))
                    .monospacedDigit()
            }
        }
        .padding(.horizontal, 18)
        .padding(.vertical, 14)
        .frame(width: 370, height: 60)
        .background(
            RoundedRectangle(cornerRadius: 15)
                .fill(.white.opacity(0.12))
                .stroke(.white.opacity(0.18), lineWidth: 1)
        )
        .shadow(color: .black.opacity(0.12), radius: 10, y: 4)
    }
}
