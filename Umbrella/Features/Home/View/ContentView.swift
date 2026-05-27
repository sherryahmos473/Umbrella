//
//  ContentView.swift
//  Umbrella
//
//  Created by Sherry Ahmos on 26/05/2026.

import SwiftUI

struct ContentView: View {
    @State private var viewModel = WeatherViewModel()
    var isNight: Bool {
            let currentHour = Calendar.current.component(.hour, from: Date())
            return currentHour < 6 || currentHour >= 18
        }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Image(isNight ? "night_sky" : "day_sky")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .ignoresSafeArea()
                    .blur(radius: 10, opaque: true)
                stateView
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .task {
                        await viewModel.fetchWeatherForCurrentLocation()
                    }
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
            NavigationStack {
                ScrollView {
                    WeatherDetailView(data: data)
                        .padding(.vertical)
                }
            }.navigationBarHidden(true)
        case .failure(let message):
            ContentUnavailableView(
                "Something went wrong",
                systemImage: "exclamationmark.triangle",
                description: Text(message)
            )
        }
    }
}
