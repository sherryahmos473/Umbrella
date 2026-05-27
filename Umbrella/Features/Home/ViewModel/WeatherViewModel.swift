//
//  WeatherViewModel.swift
//  Umbrella
//
//  Created by Sherry Ahmos on 26/05/2026.
//

import Foundation
import Observation
import CoreLocation

enum WeatherViewState: Equatable {
    case loading
    case success(WeatherResponse)
    case failure(String)
}

@MainActor
@Observable
final class WeatherViewModel {

    private(set) var state: WeatherViewState = .loading

    var weather: WeatherResponse? {
        if case .success(let data) = state { return data }
        return nil
    }
    var isLoading: Bool { state == .loading }

    private let networkManager: any WeatherNetworkManagerProtocol
    private let locationService = LocationService()

    init(networkManager: any WeatherNetworkManagerProtocol = WeatherNetworkManager.shared) {
        self.networkManager = networkManager
    }

    func fetchWeatherForCurrentLocation() async {
        state = .loading
        do {
            let location = try await locationService.requestLocation()
            let city     = await reverseGeocode(location)
            print("📍 Resolved city: \(city)")
            print(Calendar.current.component(.hour, from: Date()))
            await fetch(for: city)
        } catch let error as LocationError {
            state = .failure(error.message)
        } catch {
            state = .failure(error.localizedDescription)
        }
    }

    private func reverseGeocode(_ location: CLLocation) async -> String {
        await withCheckedContinuation { continuation in
            CLGeocoder().reverseGeocodeLocation(location) { placemarks, _ in
                let city = placemarks?.first?.locality
                    ?? placemarks?.first?.subAdministrativeArea
                    ?? placemarks?.first?.administrativeArea
                    ?? "\(location.coordinate.latitude),\(location.coordinate.longitude)"
                continuation.resume(returning: city)
            }
        }
    }

    private func fetch(for query: String) async {
        do {
            let data = try await networkManager.fetchCurrentWeather(for: query)
            state = .success(data)
        } catch let error as NetworkError {
            state = .failure(error.localizedDescription)
        } catch {
            state = .failure(error.localizedDescription)
        }
    }
}
