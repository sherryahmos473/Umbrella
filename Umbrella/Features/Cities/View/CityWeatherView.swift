//
//  CityWeatherView.swift
//  Umbrella
//
//  Created by Sherry Ahmos on 29/05/2026.

import SwiftUI

struct CityWeatherView: View {
    let cityName: String
    @State private var state: WeatherViewState = .loading
    private let networkManager: any WeatherNetworkManagerProtocol = WeatherNetworkManager.shared

    var isNight: Bool {
        let hour = Calendar.current.component(.hour, from: Date())
        return hour < 6 || hour >= 18
    }

    var body: some View {
        ZStack {
            Image(isNight ? "night_sky" : "day_sky")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .ignoresSafeArea()
                .blur(radius: 10, opaque: true)

            switch state {
            case .loading:
                ProgressView("Fetching weather…")
                    .progressViewStyle(.circular)
                    .tint(.white)

            case .success(let data):
                ScrollView {
                    WeatherDetailView(data: data)
                        .padding(.vertical)
                }

            case .failure(let message):
                ContentUnavailableView(
                    "Something went wrong",
                    systemImage: "exclamationmark.triangle",
                    description: Text(message)
                )
            }
        }
        .navigationTitle(cityName)
        .navigationBarTitleDisplayMode(.inline)
        .toolbarBackground(.ultraThinMaterial, for: .navigationBar)
        .toolbarColorScheme(.dark, for: .navigationBar)
        .task {
            await fetchWeather()
        }
    }

    private func fetchWeather() async {
        state = .loading
        do {
            let data = try await networkManager.fetchCurrentWeather(for: cityName)
            state = .success(data)
        } catch let error as NetworkError {
            state = .failure(error.localizedDescription)
        } catch {
            state = .failure(error.localizedDescription)
        }
    }
}
