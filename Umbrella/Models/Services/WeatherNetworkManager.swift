//
//  WeatherNetworkManager.swift
//  Umbrella
//
//  Created by Sherry Ahmos on 26/05/2026.
//
import Foundation

protocol WeatherNetworkManagerProtocol: Sendable {
    func fetchCurrentWeather(for city: String) async throws -> WeatherResponse
}

final class WeatherNetworkManager: WeatherNetworkManagerProtocol, Sendable {

    static let shared = WeatherNetworkManager()
    private init() {}

    private let baseURL = "https://api.weatherapi.com/v1/forecast.json"

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

    func fetchCurrentWeather(for city: String) async throws -> WeatherResponse {
        let key = try apiKey

        var components = URLComponents(string: baseURL)!
        components.queryItems = [
            URLQueryItem(name: "key", value: key),
            URLQueryItem(name: "q", value: city),
            URLQueryItem(name: "aqi", value: "no"),
            URLQueryItem(name: "alerts", value: "no"),
            URLQueryItem(name: "days", value: "3")
        ]

        guard let url = components.url else {
            throw NetworkError.invalidURL
        }

        let data: Data
        let response: URLResponse

        do {
            (data, response) = try await URLSession.shared.data(from: url)
        } catch let error as URLError {

            switch error.code {
            case .notConnectedToInternet,
                 .networkConnectionLost,
                 .cannotConnectToHost,
                 .cannotFindHost:
                throw NetworkError.noInternet

            default:
                throw error
            }
        }

        guard let http = response as? HTTPURLResponse else {
            throw NetworkError.serverError("Invalid response")
        }

        switch http.statusCode {
        case 200...299:
            break
        case 400:
            throw NetworkError.invalidCity
        case 401:
            throw NetworkError.missingAPIKey
        case 429:
            throw NetworkError.rateLimited
        default:
            throw NetworkError.serverError("HTTP \(http.statusCode)")
        }

        do {
            return try decoder.decode(WeatherResponse.self, from: data)
        } catch {
            throw NetworkError.decodingError
        }
    }
}
