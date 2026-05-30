//
//  CityListViewModel.swift
//  Umbrella
//
//  Created by Sherry Ahmos on 29/05/2026.
//
import Foundation
internal import Combine
@MainActor
final class CityListViewModel: ObservableObject {
    
    @Published var searchText = ""
    @Published private(set) var filteredCities: [City] = []
    
    private var allCities: [City] = []
    private let persistenceService: CityPersistenceServiceProtocol
    private var cancellables = Set<AnyCancellable>()
    
    init(persistenceService: CityPersistenceServiceProtocol = CityPersistenceService()) {
        self.persistenceService = persistenceService
        
        setupSearchSubscription()
    }
    
    func updateSourceData(_ latestCities: [City]) {
        self.allCities = latestCities
        self.filterData(with: searchText)
    }
    

    private func setupSearchSubscription() {
        $searchText
            .receive(on: DispatchQueue.main)
            .sink { [weak self] text in
                self?.filterData(with: text)
            }
            .store(in: &cancellables)
    }
    
    private func filterData(with text: String) {
        let cleanedQuery = text.trimmingCharacters(in: .whitespacesAndNewlines)
        if cleanedQuery.isEmpty {
            filteredCities = allCities
        } else {
            filteredCities = allCities.filter {
                $0.name.localizedCaseInsensitiveContains(cleanedQuery)
            }
        }
    }
}
