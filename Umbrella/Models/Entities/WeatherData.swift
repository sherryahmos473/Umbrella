//
//  WeatherData.swift
//  Umbrella
//
//  Created by Sherry Ahmos on 26/05/2026.
//
// WeatherData.swift
import Foundation

struct WeatherData: Codable, Sendable, Equatable {
    let location: Location
    let current: CurrentWeather
}
