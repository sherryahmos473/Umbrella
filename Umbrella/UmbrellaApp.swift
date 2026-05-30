//
//  UmbrellaApp.swift
//  Umbrella
//
//  Created by Sherry Ahmos on 26/05/2026.
//

import SwiftUI
import SwiftData

@main
struct UmbrellaApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            City.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(sharedModelContainer)
    }
}
