//
//  AppBackgroundModifier.swift
//  Umbrella
//
//  Created by Sherry Ahmos on 30/05/2026.
//

import SwiftUI

struct AppBackgroundModifier: ViewModifier {
    var isNight: Bool {
        let hour = Calendar.current.component(.hour, from: Date())
        return hour < 6 || hour >= 18
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
}
