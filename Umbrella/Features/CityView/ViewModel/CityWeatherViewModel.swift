//
//  CityWeatherViewModel.swift
//  Umbrella
//
//  Created by Sherry Ahmos on 30/05/2026.
//

import Foundation
internal import Combine

@MainActor
final class CityWeatherViewModel: ObservableObject {

    @Published private(set)
    var state: ViewState<WeatherResponse> = .loading

    private let networkManager:
    any WeatherNetworkManagerProtocol

    init(networkManager: any WeatherNetworkManagerProtocol = WeatherNetworkManager.shared) {
        self.networkManager = networkManager
    }

    func fetchWeather(for city: String) async {
        state = .loading
        do {
            let data = try await networkManager.fetchCurrentWeather(for: city)
            state = .success(data)

        } catch let error as NetworkError {
            state = .failure( error.localizedDescription)
        } catch {
            state = .failure(error.localizedDescription)
        }
    }
}
