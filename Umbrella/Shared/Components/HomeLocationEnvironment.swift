//
//  HomeLocationEnvironment.swift
//  Umbrella
//
//  Created by Sherry Ahmos on 14/07/2026.
//

import SwiftUI

struct HomeLocationKey: EnvironmentKey {
    static let defaultValue: String? = nil
}

extension EnvironmentValues {
    var homeLocationLocaltime: String? {
        get { self[HomeLocationKey.self] }
        set { self[HomeLocationKey.self] = newValue }
    }
}
