//
//  CityPersistenceServiceProtocol.swift
//  Umbrella
//
//  Created by Sherry Ahmos on 29/05/2026.
//

import Foundation
import SwiftData

protocol CityPersistenceServiceProtocol: Sendable {
    @MainActor func saveCity(name: String) throws
}

final class CityPersistenceService: CityPersistenceServiceProtocol {
    private let container: ModelContainer
    
    @MainActor
    private var context: ModelContext {
        container.mainContext
    }
    
    init(container: ModelContainer = try! ModelContainer(for: Schema([City.self]))) {
        self.container = container
    }
    
    @MainActor
    func saveCity(name: String) throws {
        let cleanedName = name.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !cleanedName.isEmpty else { return }
        
        let newCity = City(name: cleanedName)
        context.insert(newCity)
        try context.save()
        print("✅ Successfully saved city: \(cleanedName)")
    }
}
