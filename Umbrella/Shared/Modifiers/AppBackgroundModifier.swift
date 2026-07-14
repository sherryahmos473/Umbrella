//
//  AppBackgroundModifier.swift
//  Umbrella
//
//  Created by Sherry Ahmos on 30/05/2026.
//

import SwiftUI

struct AppBackgroundModifier: ViewModifier {
    var localtime: String?
    
    var isNight: Bool {
        if let localtime = localtime {
            if let hour = parseHourFromLocalTime(localtime) {
                return hour < 6 || hour >= 18
            }
        }
        // Fallback to device's current time if localtime is not provided
        let hour = Calendar.current.component(.hour, from: Date())
        return hour < 6 || hour >= 18
    }
    
    private func parseHourFromLocalTime(_ localtime: String) -> Int? {
        // localtime format is typically "2026-05-26 14:30"
        let components = localtime.split(separator: " ")
        guard components.count >= 2 else { return nil }
        
        let timeComponents = components[1].split(separator: ":")
        guard let hourString = timeComponents.first,
              let hour = Int(hourString) else { return nil }
        
        return hour
    }

    func body(content: Content) -> some View {
        ZStack {
            Image(isNight ? "night_sky" : "day_sky")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .ignoresSafeArea()
                .blur(radius: 10, opaque: true)
            
            content
        }
    }
}

extension View {
    func withWeatherBackground() -> some View {
        self.modifier(AppBackgroundModifier())
    }
    
    func withWeatherBackground(localtime: String?) -> some View {
        self.modifier(AppBackgroundModifier(localtime: localtime))
    }
}
