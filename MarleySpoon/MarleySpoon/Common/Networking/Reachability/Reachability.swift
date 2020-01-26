//
//  Reachability.swift
//  MarleySpoon
//
//  Created by Gagan Vishal on 2020/01/26.
//  Copyright © 2020 Gagan Vishal. All rights reserved.
//

import Foundation
import Network
 /*
   As per experience, Network framework works perfectly on physical Device. If you want to test this class please use real physical device.
 */

class Reachability {
    ///shared instance for given class
    static let shared = Reachability()
    ///NWPathMonitor var to perform network status
    var monitor: NWPathMonitor?
    ///Bool detect whether internet/network is available
    var isConnected: Bool {
        guard let monitor = monitor else { return false }
        return monitor.currentPath.status == .satisfied
    }
    
    //MARK:- Start network status monitoring
    func startMonitoring() {
        ///allocate monitor
        monitor = NWPathMonitor()
        let queue = DispatchQueue(label: "NetStatus_Monitor")
        monitor?.start(queue: queue)
    }
}
