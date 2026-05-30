//
//  Item.swift
//  Umbrella
//
//  Created by Sherry Ahmos on 26/05/2026.
//

import Foundation
import SwiftData

@Model
final class City {
    var name: String
    var addedAt: Date

    init(name: String) {
        self.name = name
        self.addedAt = Date()
    }
}
