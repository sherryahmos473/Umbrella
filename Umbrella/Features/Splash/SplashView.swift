//
//  SplashView.swift
//  Umbrella
//

import SwiftUI
import Lottie

struct SplashView: View {

    @State private var isActive = false

    var body: some View {

        if isActive {
            ContentView()
        } else {

            ZStack {

                LinearGradient(
                    colors: [
                        Color.blue.opacity(0.8),
                        Color.blue
                    ],
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()

                VStack(spacing: 24) {

                    LottieView(
                        name: "weather_animation",
                        loopMode: .loop
                    )
                    .frame(width: 250, height: 250)

                    Text("Umbrella")
                        .font(.system(size: 42, weight: .bold))
                        .foregroundStyle(.white)
                }
            }
            .onAppear {

                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {

                    withAnimation {
                        isActive = true
                    }
                }
            }
        }
    }
}
