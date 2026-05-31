//
//  CityWeatherView.swift
//  Umbrella
//
//  Created by Sherry Ahmos on 29/05/2026.


import SwiftUI

struct CityWeatherView: View {

    let cityName: String

    @StateObject private var viewModel = CityWeatherViewModel()

    var body: some View {

        ViewStateContainer(state: viewModel.state) { data in
            ScrollView {
                WeatherDetailView(data: data)
                    .padding(.vertical)
            }
        }
        .withWeatherBackground()
        .navigationTitle(cityName)
        .weatherNavigationStyle()

        .refreshable {
            await viewModel.fetchWeather(for: cityName)
        }
        .task {
            await viewModel.fetchWeather(for: cityName)
        }
    }
}

#Preview {
    NavigationStack {
        CityWeatherView(cityName: "London")
    }
}
