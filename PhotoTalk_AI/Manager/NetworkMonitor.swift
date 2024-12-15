//
//  NetworkMonitor.swift
//  PhotoTalk_AI
//
//  Created by Samet Korkmaz on 15.12.2024.
//

import Foundation
import Network

protocol NetworkMonitorInterface {
    var isConnected: Bool { get }
}

class NetworkMonitor: NetworkMonitorInterface {
    static let shared = NetworkMonitor()
    
    private let monitor: NWPathMonitor
    private let queue = DispatchQueue.global(qos: .background)
    var isConnected: Bool = false {
        didSet {
            print("Network status changed: \(isConnected ? "Connected" : "Disconnected")")
        }
    }
    
    private init() {
        monitor = NWPathMonitor()
        monitor.pathUpdateHandler = { path in
            self.isConnected = path.status == .satisfied
        }
        monitor.start(queue: queue)
    }
}
