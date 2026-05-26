//
//  LocationService.swift
//  Umbrella
//
//  Created by Sherry Ahmos on 26/05/2026.
//

import Foundation
import CoreLocation

enum LocationError: Error {
    case permissionDenied
    case locationUnavailable

    var message: String {
        switch self {
        case .permissionDenied:    return "Location access denied. Please enable it in Settings."
        case .locationUnavailable: return "Could not determine your location. Please try again."
        }
    }
}

@MainActor
final class LocationService: NSObject {

    private let manager = CLLocationManager()
    private var permissionContinuation: CheckedContinuation<Void, Error>?
    private var locationContinuation:   CheckedContinuation<CLLocation, Error>?

    override init() {
        super.init()
        manager.desiredAccuracy = kCLLocationAccuracyThreeKilometers
    }

    func requestLocation() async throws -> CLLocation {
        try await ensurePermission()
        return try await fetchLocation()
    }

    private func ensurePermission() async throws {
        switch manager.authorizationStatus {
        case .authorizedWhenInUse, .authorizedAlways:
            return
        case .denied, .restricted:
            throw LocationError.permissionDenied
        case .notDetermined:
            try await withCheckedThrowingContinuation { (continuation: CheckedContinuation<Void, Error>) in
                self.permissionContinuation = continuation
                self.manager.delegate = self
                self.manager.requestWhenInUseAuthorization()
            }
        @unknown default:
            throw LocationError.permissionDenied
        }
    }

    private func fetchLocation() async throws -> CLLocation {
        try await withCheckedThrowingContinuation { continuation in
            self.locationContinuation = continuation
            self.manager.delegate = self
            self.manager.requestLocation()
        }
    }
}

// MARK: - CLLocationManagerDelegate

extension LocationService: CLLocationManagerDelegate {

    nonisolated func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        Task { @MainActor in
            guard let continuation = self.permissionContinuation else { return }
            self.permissionContinuation = nil

            switch manager.authorizationStatus {
            case .authorizedWhenInUse, .authorizedAlways:
                continuation.resume()
            case .denied, .restricted:
                continuation.resume(throwing: LocationError.permissionDenied)
            case .notDetermined:
                break
            @unknown default:
                continuation.resume(throwing: LocationError.permissionDenied)
            }
        }
    }

    nonisolated func locationManager(_ manager: CLLocationManager,
                                     didUpdateLocations locations: [CLLocation]) {
        Task { @MainActor in
            guard let continuation = self.locationContinuation else { return }
            self.locationContinuation = nil
            if let location = locations.first {
                continuation.resume(returning: location)
            } else {
                continuation.resume(throwing: LocationError.locationUnavailable)
            }
        }
    }

    nonisolated func locationManager(_ manager: CLLocationManager,
                                     didFailWithError error: Error) {
        Task { @MainActor in
            guard let continuation = self.locationContinuation else { return }
            self.locationContinuation = nil
            continuation.resume(throwing: LocationError.locationUnavailable)
        }
    }
}
