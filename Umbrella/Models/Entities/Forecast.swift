//
//  ForeCast.swift
//  Umbrella
//
//  Created by Sherry Ahmos on 27/05/2026.
//

import Foundation
struct Forecast: Codable, Sendable, Equatable {
    let forecastday: [ForecastDay]
}
