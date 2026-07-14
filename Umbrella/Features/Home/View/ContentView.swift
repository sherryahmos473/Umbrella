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
    @State private var networkMonitor = NetworkMonitor.shared
    @State private var showCityList = false
    @State private var currentPage = 0
    
    private var homeLocationLocaltime: String? {
        if case .success(let data) = viewModel.state {
            return data.location.localtime
        }
        return nil
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {

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
                .withWeatherBackground(localtime: homeLocationLocaltime)
                .onChange(of: networkMonitor.isConnected) { _, isConnected in
                    if isConnected {
                        Task {
                            await viewModel.fetchWeatherForCurrentLocation()
                        }
                    }
                }
                .refreshable {
                    await viewModel.fetchWeatherForCurrentLocation()
                }
                .task {
                    if case .loading = viewModel.state {
                        await viewModel.fetchWeatherForCurrentLocation()
                    }
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
                        .environment(\.homeLocationLocaltime, homeLocationLocaltime)
                }
                .onChange(of: showCityList) { _, isPresented in
                    if !isPresented {
                        currentPage = 0
                    }
                }
            }

            if !networkMonitor.isConnected {
                Text("No Internet Connection")
                    .font(.subheadline.weight(.semibold))
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(.red)
                    .transition(.move(edge: .top))
            }
            
            // Page Indicator
            HStack(spacing: 8) {
                ForEach(0..<2, id: \.self) { index in
                    Circle()
                        .fill(index == currentPage ? .white : .white.opacity(0.4))
                        .frame(width: 8, height: 8)
                        .animation(.easeInOut(duration: 0.3), value: currentPage)
                }
            }
            .padding(.bottom, 20)
        }
    }

    private func handleSwipe(_ value: DragGesture.Value) {

        let isLeftSwipe = value.translation.width < -50

        let isHorizontal = abs(value.translation.width) > abs(value.translation.height)

        if isLeftSwipe && isHorizontal {
            showCityList = true
            currentPage = 1
        }
    }
}

#Preview {
    ContentView()
}
