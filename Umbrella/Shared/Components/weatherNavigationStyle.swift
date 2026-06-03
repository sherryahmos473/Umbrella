//
//  weatherNavigationStyle.swift
//  Umbrella
//
//  Created by Sherry Ahmos on 30/05/2026.
//
import SwiftUI

extension View {

    func weatherNavigationStyle() -> some View {
        self
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(
                .ultraThinMaterial,
                for: .navigationBar
            )
            .toolbarColorScheme(
                .dark,
                for: .navigationBar
            )
    }
}
