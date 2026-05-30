//
//  DailyDetailsViewModel.swift
//  Umbrella
//
//  Created by Sherry Ahmos on 27/05/2026.
//

import Foundation

@Observable
final class DailyDetailsViewModel {

    let hourlyData: [HourForecast]

    init(hourlyData: [HourForecast]) {
        self.hourlyData = hourlyData
    }

    var upcomingHours: [HourForecast] {

        let now = Date()

        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm"

        guard let firstHour = hourlyData.first,
              let firstDate = formatter.date(from: firstHour.time),
              Calendar.current.isDateInToday(firstDate)
        else {
            return hourlyData
        }

        return hourlyData.filter {

            guard let hourDate = formatter.date(from: $0.time) else {
                return false
            }

            return hourDate >= now
        }
    }

    func formattedTime(_ timeString: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        guard let date = formatter.date(from: timeString) else { return timeString }
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: date)
    }
}

