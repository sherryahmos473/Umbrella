//
//  ContentView.swift
//  Umbrella
//
//  Created by Sherry Ahmos on 26/05/2026.
//
import SwiftUI

struct ContentView: View {

    @State private var viewModel = WeatherViewModel()

    var body: some View {
        NavigationStack {
            stateView
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .navigationTitle("Umbrella ☂️")
                .task {
                    await viewModel.fetchWeatherForCurrentLocation()
                }
        }
    }

    @ViewBuilder
    private var stateView: some View {
        switch viewModel.state {
        case .loading:
            ProgressView("Fetching weather…")
                .progressViewStyle(.circular)
        case .success(let data):
            ScrollView {
                WeatherDetailView(data: data)
                    .padding()
            }
        case .failure(let message):
            ContentUnavailableView(
                "Something went wrong",
                systemImage: "exclamationmark.triangle",
                description: Text(message)
            )
        }
    }
}

// MARK: - WeatherDetailView

struct WeatherDetailView: View {
    let data: WeatherData

    var body: some View {
        VStack(spacing: 12) {
            Text(data.location.name)
                .font(.largeTitle.bold())
            Text("\(data.location.region), \(data.location.country)")
                .font(.subheadline)
                .foregroundStyle(.secondary)

            Text("\(data.current.tempC, specifier: "%.1f")°C")
                .font(.system(size: 64, weight: .thin))

            Text(data.current.condition.text)
                .font(.title3)

            Divider()

            Grid(alignment: .leading, horizontalSpacing: 24, verticalSpacing: 10) {
                weatherRow(label: "Feels like", value: "\(data.current.feelslikeC, default: "%.1f")°C")
                weatherRow(label: "Humidity",   value: "\(data.current.humidity)%")
                weatherRow(label: "Wind",       value: "\(data.current.windKph, default: "%.1f") km/h \(data.current.windDir)")
                weatherRow(label: "Visibility", value: "\(data.current.visKm, default: "%.1f") km")
                weatherRow(label: "UV Index",   value: "\(data.current.uv, default: "%.1f")")
                weatherRow(label: "Pressure",   value: "\(data.current.pressureMb, default: "%.0f") mb")
            }
        }
        .padding()
        .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 16))
    }

    private func weatherRow(label: String, value: String) -> some View {
        GridRow {
            Text(label).foregroundStyle(.secondary)
            Text(value).fontWeight(.medium)
        }
    }
}
