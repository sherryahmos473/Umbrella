//
//  CityListViewModel.swift
//  Umbrella
//
//  Created by Sherry Ahmos on 29/05/2026.
//
//
//  CityListViewModel.swift
//  Umbrella
//

import Foundation
internal import Combine

@MainActor
final class CityListViewModel:
ObservableObject {

    @Published var searchText = "" {
        didSet {
            filterCities()
        }
    }

    @Published private(set)
    var filteredCities: [City] = []

    private var sourceCities: [City] = []

    func updateSourceData(
        _ cities: [City]
    ) {

        sourceCities = cities
        filterCities()
    }

    private func filterCities() {

        guard !searchText.isEmpty else {

            filteredCities = sourceCities
            return
        }

        filteredCities =
        sourceCities.filter {

            $0.name.localizedCaseInsensitiveContains(
                searchText
            )
        }
    }
}
