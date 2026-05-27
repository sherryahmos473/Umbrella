//
//  HourlyCell.swift
//  Umbrella
//
//  Created by Sherry Ahmos on 27/05/2026.
//

import SwiftUI

struct HourlyCell: View {
    let time: String
    let condition: String
    let icon: String
    let temp: Int
    let feelsLike: Int

    var body: some View {
        HStack(spacing: 12) {
            Text(time)
                .font(.subheadline.bold())
                .frame(width: 55, alignment: .leading)
                .monospacedDigit()

            AsyncImage(url: URL(string: "https:\(icon)")) { phase in
                switch phase {
                case .success(let image):
                    image.resizable().scaledToFit()
                default:
                    Image(systemName: "cloud.sun.fill")
                }
            }
            .frame(width: 40, height: 40)

            Text(condition)
                .font(.subheadline)
                .lineLimit(1)
                .minimumScaleFactor(0.8)

            Spacer()

            VStack(alignment: .trailing, spacing: 2) {
                Text("\(temp)°C")
                    .font(.subheadline.bold())
                Text("Feels \(feelsLike)°")
                    .font(.caption)
                    .opacity(0.7)
            }
            .monospacedDigit()
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .frame(width: 370,height: 60)
        .background(
            RoundedRectangle(cornerRadius: 14)
                .fill(.white.opacity(0.15))
                .stroke(.white.opacity(0.2), lineWidth: 0.5)
        )
    }
}
