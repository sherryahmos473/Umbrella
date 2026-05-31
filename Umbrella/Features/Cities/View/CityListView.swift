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

    @State private var cityToDelete: City?

    @State private var showDeleteAlert = false

    var body: some View {

        ZStack {
            if viewModel.filteredCities.isEmpty {
                EmptyStateView(
                    title: "No Saved Cities",
                    systemImage: "map",
                    message:
                        viewModel.searchText.isEmpty
                        ? "Tap + to add a city."
                        : "No matching cities found."
                )
                .foregroundStyle(.white)

            } else {
                ScrollView {
                    VStack(spacing: 12) {
                        ForEach( viewModel.filteredCities) { city in
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
        .withWeatherBackground()
        .navigationTitle("My Cities")
        .weatherNavigationStyle()
        .searchable(
            text: $viewModel.searchText,
            placement: .navigationBarDrawer(displayMode: .automatic),
            prompt: "Search cities"
        )
        .task {
            viewModel.updateSourceData(cities)
        }
        .onChange(of: cities) { _, newCities in
            viewModel.updateSourceData(newCities)
        }
        .alert("Delete City",isPresented: $showDeleteAlert, presenting: cityToDelete) { city in
            Button("Delete", role: .destructive) {
                modelContext.delete(city)
                try? modelContext.save()
            }
            Button(
                "Cancel",
                role: .cancel
            ) { }

        } message: { city in
            Text(
                """
                Are you sure you want to remove \
                \(city.name) from your cities?
                """
            )
        }
    }
}

#Preview {
    NavigationStack {
        CityListView()
    }
}
