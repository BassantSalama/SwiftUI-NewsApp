//
//  NetworkMonitor.swift
//  SwiftUI-NewsApp
//
//  Created by mac on 18/12/2025.
//

import Foundation
import Network
import SwiftUI

class NetworkMonitor: ObservableObject {
    @Published var isConnected: Bool
    
    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue(label: "NetworkMonitor")
    
    init() {
        
        self.isConnected = monitor.currentPath.status == .satisfied
        
        monitor.pathUpdateHandler = { [weak self] path in
            DispatchQueue.main.async {
                self?.isConnected = (path.status == .satisfied)
            }
        }
        monitor.start(queue: queue)
    }
    
    deinit {
        monitor.cancel()
    }
}

