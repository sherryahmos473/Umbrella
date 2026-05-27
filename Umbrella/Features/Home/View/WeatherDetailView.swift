//
//  WeatherDetailView.swift
//  Umbrella
//
//  Created by Sherry Ahmos on 27/05/2026.
//

import SwiftUI

struct WeatherDetailView: View {
    let data: WeatherResponse
    
    var body: some View {
        VStack(spacing: 20) {
            VStack(spacing: 4) {
                Text(data.location.name)
                    .font(.largeTitle)
                    .foregroundStyle(.white)
                Text("\(data.location.region), \(data.location.country)")
                    .font(.subheadline)
                    .foregroundStyle(.white)
            }
            
            VStack(spacing: 8) {
                Text("\(data.current.tempC, specifier: "%.1f")°C")
                    .font(.system(size: 76, weight: .ultraLight))
                    .foregroundStyle(.white)
                    .accessibilityLabel("\(Int(data.current.tempC)) degrees Celsius")
                Text(data.current.condition.text)
                    .font(.title3)
                .foregroundStyle(.white)
            }
            
            Divider()
            VStack(spacing: 10) {
                ForEach(data.forecast.forecastday, id: \.dateEpoch) { day in
                    ForecastCell(forecast: day)
                }
            }
            .padding(.horizontal)
            Divider()

            Grid(horizontalSpacing: 16, verticalSpacing: 16) {
                GridRow {
                    WeatherMetricCell(
                        icon: "thermometer.medium",
                        label: "Feels Like",
                        value: "\(data.current.feelslikeC, default: "%.1f")°C"
                    )
                    WeatherMetricCell(
                        icon: "humidity",
                        label: "Humidity",
                        value: "\(data.current.humidity)%"
                    )
                }
                GridRow {
                    WeatherMetricCell(
                        icon: "wind",
                        label: "Wind",
                        value: "\(data.current.windKph, default: "%.1f") km/h \(data.current.windDir)"
                    )
                    WeatherMetricCell(
                        icon: "eye",
                        label: "Visibility",
                        value: "\(data.current.visKm, default: "%.1f") km"
                    )
                }
                GridRow {
                    WeatherMetricCell(
                        icon: "sun.max",
                        label: "UV Index",
                        value: "\(data.current.uv, default: "%.1f")"
                    )
                    WeatherMetricCell(
                        icon: "barometer",
                        label: "Pressure",
                        value: "\(data.current.pressureMb, default: "%.0f") mb"
                    )
                }
            }
        }
        .frame(maxWidth: .infinity)
        .aspectRatio(1, contentMode: .fit)
        .shadow(color: .black.opacity(0.15), radius: 10, x: 0, y: 5)
    }
}
