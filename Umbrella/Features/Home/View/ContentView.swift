//
//  ContentView.swift
//  Umbrella
//
//  Created by Sherry Ahmos on 26/05/2026.
//

import SwiftUI

struct ContentView: View {
    @State private var viewModel = WeatherViewModel()
    @State private var showCityList = false

    var isNight: Bool {
        let hour = Calendar.current.component(.hour, from: Date())
        return hour < 6 || hour >= 18
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
            }
            .task {
                await viewModel.fetchWeatherForCurrentLocation()
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink {
                        AddCityView()
                    } label: {
                        Image(systemName: "plus")
                            .font(.body.bold())
                            .foregroundStyle(.white)
                    }
                }
            }

            .navigationDestination(isPresented: $showCityList) {
                CityListView()
            }
        }
    }

    @ViewBuilder
    private var stateView: some View {
        switch viewModel.state {

        case .loading:
            ProgressView("Fetching weather…")
                .progressViewStyle(.circular)
                .tint(.white)

        case .success(let data):
            ScrollView {
                WeatherDetailView(data: data)
                    .padding(.vertical)
            }
            .gesture(
                DragGesture(minimumDistance: 50)
                    .onEnded { value in
                        let isLeftSwipe = value.translation.width < -50
                        let isHorizontal =
                        abs(value.translation.width) >
                        abs(value.translation.height)

                        if isLeftSwipe && isHorizontal {
                            showCityList = true
                        }
                    }
            )

        case .failure(let message):
            ContentUnavailableView(
                "Something went wrong",
                systemImage: "exclamationmark.triangle",
                description: Text(message)
            )
        }
    }
}
