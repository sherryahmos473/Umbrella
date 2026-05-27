//
//  ForecastDay.swift
//  Umbrella
//
//  Created by Sherry Ahmos on 27/05/2026.
//

import Foundation

struct ForecastDay: Codable, Sendable, Equatable {
    let date: String
    let dateEpoch: Int
    let day: DaySummary
    let astro: Astronomy
    let hour: [HourForecast]

    enum CodingKeys: String, CodingKey {
        case date
        case dateEpoch = "date_epoch"
        case day, astro, hour
    }
}
