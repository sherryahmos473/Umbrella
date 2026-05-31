//
//  CitySearchViewModel.swift
//  Umbrella
//
//  Created by Sherry Ahmos on 29/05/2026.
//

import Foundation
internal import Combine

@MainActor
final class AddCityViewModel: ObservableObject {
    private let persistenceService: CityPersistenceServiceProtocol
    let countries = ["Cairo", "Alexandria", "London", "New York","Span","Germany","Italy","Japan"]
    
    @Published var errorMessage: String?
    @Published var isSaveSuccess = false
    
    init(persistenceService: CityPersistenceServiceProtocol = CityPersistenceService()) {
        self.persistenceService = persistenceService
    }
    
    func addCityToFavorites(_ cityName: String) {
        do {
            try persistenceService.saveCity(name: cityName)
            self.isSaveSuccess = true
            self.errorMessage = nil
        } catch {
            self.errorMessage = "Failed to save city: \(error.localizedDescription)"
            self.isSaveSuccess = false
        }
    }
}
