
//
//  Protocols.swift
//  Networker
//


import Foundation
import SystemConfiguration

//MARK: Reachability Protocol
public protocol Reachable {
    
    /// - Returns: return network status
    static func status() -> NetworkStatus
    /// Start listening for reachability notifications on the current run loop.
    ///
    /// - Returns: return result
    func register() -> Bool
    
    /// stop listening for reachability notifications
    func unregister()
    
    /// current reachability status
    var currentStatus: NetworkStatus { get }
}

//MARK: Network Status
public enum NetworkStatus {
    case notReachable,  reachableViaWiFi, reachableViaWWAN
}
