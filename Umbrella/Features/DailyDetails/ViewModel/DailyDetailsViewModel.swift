//
//  DailyDetailsViewModel.swift
//  Umbrella
//
//  Created by Sherry Ahmos on 27/05/2026.
//

import Foundation
import Observation

@MainActor
@Observable
final class DailyDetailsViewModel {

    let hourlyData: [HourForecast]

    init(hourlyData: [HourForecast]) {
        self.hourlyData = hourlyData
    }

    var upcomingHours: [HourForecast] {
        let currentEpoch = Int(Date().timeIntervalSince1970)
        let upcoming = hourlyData.filter { $0.timeEpoch >= currentEpoch }
        return upcoming.isEmpty ? hourlyData : upcoming
    }

    func formattedTime(_ timeString: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        guard let date = formatter.date(from: timeString) else { return timeString }
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: date)
    }
}
