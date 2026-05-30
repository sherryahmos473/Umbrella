//  WeatherDetailView.swift
//  Umbrella
//
//  Created by Sherry Ahmos on 27/05/2026.

import SwiftUI

struct WeatherPagerView: View {
    let locations: [WeatherResponse]
    @State private var currentIndex: Int = 0

    var body: some View {
        TabView(selection: $currentIndex) {
            ForEach(locations.indices, id: \.self) { index in
                ScrollView(.vertical, showsIndicators: false) {
                    WeatherDetailView(data: locations[index])
                }
                .tag(index)
            }
        }
        .tabViewStyle(.page(indexDisplayMode: .always))
        .ignoresSafeArea()
    }
}
