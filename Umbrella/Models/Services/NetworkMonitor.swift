//
//  NetworkMonitor.swift
//  Umbrella
//
//  Created by Sherry Ahmos on 03/06/2026.
//

import Network
import Observation

@Observable
final class NetworkMonitor {

    static let shared = NetworkMonitor()

    var isConnected = true

    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue(label: "NetworkMonitor")

    private init() {

        monitor.pathUpdateHandler = { [weak self] path in
            Task { @MainActor in
                self?.isConnected = path.status == .satisfied
                print("Internet:", path.status == .satisfied)
            }
        }

        monitor.start(queue: queue)
    }
}
