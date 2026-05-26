//
//  WeatherData.swift
//  Umbrella
//
//  Created by Sherry Ahmos on 26/05/2026.
//
import Foundation
struct WeatherData: Codable {
    let location: Location
    let current: CurrentWeather
}
