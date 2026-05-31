//
//  ContentView.swift
//  Umbrella
//
//  Created by Sherry Ahmos on 26/05/2026.
//
//
//  ContentView.swift
//  Umbrella
//

import SwiftUI

struct ContentView: View {

    @State private var viewModel = WeatherViewModel()

    @State private var showCityList = false

    var body: some View {
        NavigationStack {
            ViewStateContainer(state: viewModel.state) { data in
                ScrollView {
                    WeatherDetailView(data: data)
                        .padding(.vertical)
                }
                .gesture(
                    DragGesture(minimumDistance: 50)
                        .onEnded(handleSwipe)
                )
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .withWeatherBackground()
            .refreshable {
                await viewModel.fetchWeatherForCurrentLocation()
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

    private func handleSwipe(_ value: DragGesture.Value) {

        let isLeftSwipe = value.translation.width < -50

        let isHorizontal = abs(value.translation.width) > abs(value.translation.height)

        if isLeftSwipe && isHorizontal {
            showCityList = true
        }
    }
}

#Preview {
    ContentView()
}
