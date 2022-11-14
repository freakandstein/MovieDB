//
//  NetworkMonitorService.swift
//  MovieDB
//
//  Created by Satrio Wicaksono on 14/11/22.
//

import Foundation
import Network

public protocol NetworkMonitorServiceProtocol: AnyObject {
    var isOnline: Bool { get set }
    
    func monitorNetwork()
}

public class NetworkMonitorService: NetworkMonitorServiceProtocol {
    
    public static let shared = NetworkMonitorService()
    public var isOnline: Bool = false
    private var monitor: NWPathMonitor?
    private var queue: DispatchQueue?
    
    public init() {
        if monitor == nil {
            monitor = NWPathMonitor()
            queue = DispatchQueue(label: "Monitor")
        }
    }
    
    public func monitorNetwork() {
        monitor?.pathUpdateHandler = { [weak self] path in
            guard let self = self else { return }
            if path.status == .satisfied {
                self.isOnline = true
            } else {
                self.isOnline = false
            }
        }
        if let queue = queue, let monitor = monitor {
            monitor.start(queue: queue)
        }
    }
}




