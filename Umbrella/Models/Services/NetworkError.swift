//
//  NetworkError.swift
//  Umbrella
//
//  Created by Sherry Ahmos on 26/05/2026.
//

import Foundation

enum NetworkError: LocalizedError {
    case invalidURL
    case invalidCity
    case missingAPIKey
    case rateLimited
    case noInternet
    case decodingError
    case serverError(String)

    var errorDescription: String? {
        switch self {
        case .noInternet:
            return "No Internet Connection"
        case .invalidCity:
            return "City not found"
        case .missingAPIKey:
            return "Missing API Key"
        case .rateLimited:
            return "Too many requests"
        case .decodingError:
            return "Unable to read weather data"
        case .invalidURL:
            return "Invalid URL"
        case .serverError(let message):
            return message
        }
    }
}
