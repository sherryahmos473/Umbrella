//
//  CityListItem.swift
//  Umbrella
//
//  Created by Sherry Ahmos on 29/05/2026.
//


import SwiftUI

struct CityListItem: View {
    var name: String
    var onDelete: () -> Void

    var body: some View {
        HStack {
            Image(systemName: "location.fill")
                .foregroundStyle(.white.opacity(0.7))

            Text(name)
                .font(.title3.weight(.medium))
                .foregroundStyle(.white)

            Spacer()

            Button {
                onDelete()
            } label: {
                Image(systemName: "trash")
                    .foregroundStyle(.red.opacity(0.9))
                    .padding(8)
            }
            .buttonStyle(.plain)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .frame(width: 370, height: 60)
        .background(
            RoundedRectangle(cornerRadius: 22)
                .fill(.white.opacity(0.12))
                .stroke(.white.opacity(0.18), lineWidth: 1)
        )
        .shadow(color: .black.opacity(0.12), radius: 10, y: 4)
    }
}
