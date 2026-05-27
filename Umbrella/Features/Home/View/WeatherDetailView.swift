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
                    .foregroundStyle(.white.opacity(0.8))
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

            Divider().overlay(.white.opacity(0.3))

            VStack(spacing: 10) {
                Text("3-day forecast")
                    .font(.headline)
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity, alignment: .leading)

                ForEach(data.forecast.forecastday, id: \.dateEpoch) { day in
                    NavigationLink {
                        DailyDetailsView(data: day.hour)
                    } label: {
                        ForecastCell(
                            label: day.date,
                            condition: day.day.condition.text,
                            icon: day.day.condition.icon,
                            maxTemp: Int(day.day.maxtempC),
                            minTemp: Int(day.day.mintempC)
                        )
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding(.horizontal)

            Divider().overlay(.white.opacity(0.3))

            Grid(horizontalSpacing: 16, verticalSpacing: 16) {
                GridRow {
                    WeatherMetricCell(icon: "thermometer.medium", label: "Feels Like",
                                      value: "\(data.current.feelslikeC, default: "%.1f")°C")
                    WeatherMetricCell(icon: "humidity", label: "Humidity",
                        value: "\(data.current.humidity)%")
                }
                GridRow {
                    WeatherMetricCell(icon: "wind", label: "Wind",
                        value: "\(data.current.windKph, default: "%.1f") km/h \(data.current.windDir)")
                    WeatherMetricCell(icon: "eye", label: "Visibility",
                        value: "\(data.current.visKm, default: "%.1f") km")
                }
                GridRow {
                    WeatherMetricCell(icon: "sun.max", label: "UV Index",
                        value: "\(data.current.uv, default: "%.1f")")
                    WeatherMetricCell(icon: "barometer", label: "Pressure",
                        value: "\(data.current.pressureMb, default: "%.0f") mb")
                }
            }
            .padding(.horizontal)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical)
    }
}
