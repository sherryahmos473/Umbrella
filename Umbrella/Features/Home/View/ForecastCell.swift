//
//  ForecastCell.swift
//  Umbrella
//
//  Created by Sherry Ahmos on 27/05/2026.
//

import SwiftUI

struct ForecastCell: View {
    var label:String
    var condition:String
    var icon:String
    var maxTemp:Int
    var minTemp:Int
    
    var body: some View {
        HStack {
            Text(label)
                .font(.body.bold())
                .foregroundStyle(.primary)
            AsyncImage(url: URL(string: "https:\(icon)")) { phase in
                switch phase {
                case .success(let image):
                    image.resizable().scaledToFit()
                default:
                    Image(systemName: "cloud.sun.fill")
                }
            }
            .frame(width: 36, height: 36)
            Text(condition)
                .font(.subheadline)
            
            HStack(spacing: 8) {
                    Text("\(maxTemp)°")
                    .font(.system(.body, design: .rounded, weight: .bold))
                        .foregroundStyle(.primary)
                        .monospacedDigit()
                    
                    Text("\(minTemp)°")
                    .font(.subheadline)
                }
        }
        .padding()
        .frame(width: 370,height: 60)
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 16))
        .padding(.vertical, 8)
    }
}
