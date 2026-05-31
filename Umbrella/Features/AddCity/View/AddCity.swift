//
//  CityCell.swift
//  Umbrella
//
//  Created by Sherry Ahmos on 29/05/2026.
//

import SwiftUI

struct AddCity: View {
    var city: String
    var onAddTapped: () -> Void 
    
    var body: some View {
        HStack(spacing: 12) {
            Text(city)
                .font(.system(.subheadline, design: .rounded, weight: .bold))
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            
            Button {
                onAddTapped()
            } label: {
                Image(systemName: "plus")
                    .foregroundStyle(.white)
                    .font(.body.bold())
                    .frame(width: 32, height: 32)
                    .background(.white.opacity(0.1), in: Circle())
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .frame(width: 370,height: 60)
        .background(
            RoundedRectangle(cornerRadius: 22)
                .fill(.white.opacity(0.12))
                .stroke(.white.opacity(0.18), lineWidth: 1)
        )
        .shadow(color: .black.opacity(0.12), radius: 10, y: 4)
    }
}
