//
//  WeatherViewModel.swift
//  Umbrella
//
//  Created by Sherry Ahmos on 26/05/2026.
//

import Foundation
import Observation
import CoreLocation

@MainActor
@Observable
final class WeatherViewModel {
    private(set) var state: ViewState<WeatherResponse> = .loading


    private let networkManager: any WeatherNetworkManagerProtocol
    private let locationService = LocationService()

    let networkMonitor = NetworkMonitor.shared


    init(networkManager: any WeatherNetworkManagerProtocol = WeatherNetworkManager.shared) {
        self.networkManager = networkManager
    }

    func fetchWeatherForCurrentLocation() async {
        state = .loading
        do {
            let location = try await locationService.requestLocation()
            let city = await reverseGeocode(location)
            print("📍 Resolved city: \(city)")
            await fetchWeather(for: city)
        } catch let error as LocationError {
            state = .failure(error.message)
        } catch {
            state = .failure(error.localizedDescription)
        }
    }

    func fetchWeather(for cityName: String) async {

        print("Fetching weather for:", cityName)

        guard networkMonitor.isConnected else {
            print("No internet")
            state = .noInternet
            return
        }

        state = .loading

        do {
            let data = try await networkManager.fetchCurrentWeather(for: cityName)
            print("Success")
            state = .success(data)

        } catch let error as NetworkError {
            print("NetworkError:", error)

            switch error {
            case .noInternet:
                state = .noInternet
            default:
                state = .failure(error.localizedDescription)
            }

        } catch {
            print("Error:", error)
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
}
