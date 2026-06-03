//
//  ViewStateContainer.swift
//  Umbrella
//
//  Created by Sherry Ahmos on 30/05/2026.
//


import SwiftUI
import Lottie

struct ViewStateContainer<Content: View, T>: View {

    let state: ViewState<T>
    let content: (T) -> Content

    var body: some View {
        switch state {

        case .loading:
            VStack(spacing: 16) {
                LottieView(
                    name: "weather_loading",
                    loopMode: .loop
                )
                .frame(width: 150, height: 150)

                Text("Fetching weather…")
                    .font(.headline)
                    .foregroundStyle(.white)
            }

        case .success(let value):
            content(value)

        case .noInternet:
               ContentUnavailableView(
                   "No Internet Connection",
                   systemImage: "wifi.slash",
                   description: Text("Please check your connection and try again.")
               ).foregroundStyle(.white)

           case .failure(let message):
               ContentUnavailableView(
                   "Something went wrong",
                   systemImage: "exclamationmark.triangle",
                   description: Text(message)
               ).foregroundStyle(.white)
           }
    }
}
