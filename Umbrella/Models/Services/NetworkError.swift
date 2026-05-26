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
    case decodingFailed
    case noInternet
    case serverError(String)

    var errorDescription: String? {
        switch self {
        case .invalidURL:       return "The request URL was invalid."
        case .invalidCity:      return "City not found. Please check the name and try again."
        case .missingAPIKey:    return "API key is missing or invalid."
        case .rateLimited:      return "Too many requests. Please wait a moment."
        case .decodingFailed:   return "Failed to decode the server response."
        case .noInternet:       return "No internet connection."
        case .serverError(let msg): return "Server error: \(msg)"
        }
    }
}
