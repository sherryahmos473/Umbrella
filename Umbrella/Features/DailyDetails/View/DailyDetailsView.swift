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

    var isNight: Bool {
        let hour = Calendar.current.component(.hour, from: Date())
        return hour < 6 || hour >= 18
    }

    init(data: [HourForecast]) {
        self.data = data
        _viewModel = State(initialValue: DailyDetailsViewModel(hourlyData: data))
    }

    var body: some View {
        ZStack {
            Image(isNight ? "night_sky" : "day_sky")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .ignoresSafeArea()
                .blur(radius: 10, opaque: true)

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
            }
        }
        .navigationTitle("Hourly Forecast")
        .navigationBarTitleDisplayMode(.inline)
        .toolbarBackground(.ultraThinMaterial, for: .navigationBar)
        .toolbarColorScheme(.dark, for: .navigationBar)
    }
}
