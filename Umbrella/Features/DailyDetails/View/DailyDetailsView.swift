//
//  DailyDetailsView.swift
//  Umbrella
//
//  Created by Sherry Ahmos on 27/05/2026.
//
import SwiftUI

struct DailyDetailsView: View {
    let data: [HourForecast]

    @State private var viewModel: DailyDetailsViewModel

    init(data: [HourForecast]) {
        self.data = data
        _viewModel = State(initialValue: DailyDetailsViewModel(hourlyData: data))
    }

    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 12) {
                ForEach(viewModel.upcomingHours, id: \.timeEpoch) { hour in
                    HourlyCell(
                        time: viewModel.formattedTime(hour.time),
                        condition: hour.condition.text,
                        icon: hour.condition.icon,
                        temp: Int(hour.tempC),
                        feelsLike: Int(hour.feelslikeC)
                    )
                }
            }
            .padding()
        }.withWeatherBackground()
        .navigationTitle("Hourly Forecast")
        .weatherNavigationStyle()
    }
}
