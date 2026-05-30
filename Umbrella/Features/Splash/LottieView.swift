//
//  LottieView.swift
//  Umbrella
//
//  Created by Sherry Ahmos on 29/05/2026.
//

import SwiftUI
import Lottie

struct LottieView: UIViewRepresentable {

    let name: String
    let loopMode: LottieLoopMode

    func makeUIView(context: Context) -> UIView {

        let view = UIView(frame: .zero)

        let animationView = LottieAnimationView(name: name)

        animationView.loopMode = loopMode
        animationView.play()

        animationView.contentMode = .scaleAspectFit
        animationView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(animationView)

        NSLayoutConstraint.activate([
            animationView.widthAnchor.constraint(equalTo: view.widthAnchor),
            animationView.heightAnchor.constraint(equalTo: view.heightAnchor)
        ])

        return view
    }

    func updateUIView(_ uiView: UIView, context: Context) { }
}
