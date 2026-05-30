//
//  CityListView.swift
//  Umbrella
//
//  Created by Sherry Ahmos on 29/05/2026.
//

import SwiftUI
import SwiftData

struct CityListView: View {
    @Query(sort: \City.addedAt) private var cities: [City]
    @Environment(\.modelContext) private var modelContext

    @StateObject private var viewModel = CityListViewModel()

    @State private var cityToDelete: City? = nil
    @State private var showDeleteAlert = false

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

            if viewModel.filteredCities.isEmpty {
                ContentUnavailableView(
                    "No Saved Cities",
                    systemImage: "map",
                    description: Text(
                        viewModel.searchText.isEmpty
                        ? "Tap + to add a city."
                        : "No matching cities found."
                    )
                ).foregroundStyle(.white)
            } else {
                ScrollView {
                    VStack(spacing: 12) {
                        ForEach(viewModel.filteredCities) { city in
                            NavigationLink {
                                CityWeatherView(cityName: city.name)
                            } label: {
                                CityListItem(name: city.name) {
                                    cityToDelete = city
                                    showDeleteAlert = true
                                }
                            }
                            .buttonStyle(.plain)
                        }
                    }
                    .padding()
                }
            }
        }
        .navigationTitle("My Cities")
        .navigationBarTitleDisplayMode(.inline)
        .toolbarBackground(.ultraThinMaterial, for: .navigationBar)
        .toolbarColorScheme(.dark, for: .navigationBar)

        .searchable(
            text: $viewModel.searchText,
            placement: .navigationBarDrawer(displayMode: .automatic),
            prompt: "Search cities"
        )

        .onAppear {
            viewModel.updateSourceData(cities)
        }
        .onChange(of: cities) { _, newCities in
            viewModel.updateSourceData(newCities)
        }

        .alert(
            "Delete City",
            isPresented: $showDeleteAlert,
            presenting: cityToDelete
        ) { city in
            Button("Delete", role: .destructive) {
                modelContext.delete(city)
                try? modelContext.save()
            }

            Button("Cancel", role: .cancel) { }

        } message: { city in
            Text("Are you sure you want to remove \(city.name) from your cities?")
        }
    }
}
