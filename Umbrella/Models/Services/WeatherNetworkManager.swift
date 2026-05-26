//
//  WeatherNetworkManager.swift
//  Umbrella
//
//  Created by Sherry Ahmos on 26/05/2026.
//
import Foundation

protocol WeatherNetworkManagerProtocol: Sendable {
    func fetchCurrentWeather(for city: String) async throws -> WeatherData
}

final class WeatherNetworkManager: WeatherNetworkManagerProtocol, Sendable {

    static let shared = WeatherNetworkManager()
    private init() {}

    private let baseURL = "https://api.weatherapi.com/v1/current.json"

    private let decoder = JSONDecoder()  

    private var apiKey: String {
        get throws {
            guard
                let key = Bundle.main.object(forInfoDictionaryKey: "WeatherApiKey") as? String,
                !key.isEmpty
            else { throw NetworkError.missingAPIKey }
            return key
        }
    }

    func fetchCurrentWeather(for city: String) async throws -> WeatherData {
        let key = try apiKey

        var components = URLComponents(string: baseURL)!
        components.queryItems = [
            URLQueryItem(name: "key", value: key),
            URLQueryItem(name: "q",   value: city),
            URLQueryItem(name: "aqi", value: "no")
        ]

        guard let url = components.url else { throw NetworkError.invalidURL }

        let (data, response) = try await URLSession.shared.data(from: url)

        guard let http = response as? HTTPURLResponse else {
            throw NetworkError.serverError("Invalid response")
        }

        switch http.statusCode {
        case 200...299: break
        case 400:       throw NetworkError.invalidCity
        case 401:       throw NetworkError.missingAPIKey
        case 429:       throw NetworkError.rateLimited
        default:        throw NetworkError.serverError("HTTP \(http.statusCode)")
        }

        do {
            return try decoder.decode(WeatherData.self, from: data)
        } catch let error as DecodingError {
            switch error {
            case .keyNotFound(let key, let ctx):
                print("❌ Key '\(key.stringValue)' not found at \(ctx.codingPath.map(\.stringValue))")
            case .typeMismatch(_, let ctx):
                print("❌ Type mismatch at \(ctx.codingPath.map(\.stringValue)): \(ctx.debugDescription)")
            case .valueNotFound(_, let ctx):
                print("❌ Value not found at \(ctx.codingPath.map(\.stringValue))")
            case .dataCorrupted(let ctx):
                print("❌ Corrupted: \(ctx.debugDescription)")
            @unknown default:
                print("❌ \(error)")
            }
            throw NetworkError.decodingFailed
        }
    }
}
