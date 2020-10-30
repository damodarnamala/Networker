
//
//  Networker.swift
//  Networker
//

import Foundation
import SystemConfiguration


//MARK: Net Reachability
public final  class Networker: Reachable {
    
    public static let shared = Networker()
    
    public static func status() -> NetworkStatus {
        let reach = Networker.shared
        return reach.currentStatus
    }
    
    private var reachability: SCNetworkReachability?
   
    public init() {
        reachability = SCNetworkReachabilityCreateWithName(nil, "www.apple.com")
    }
    
    deinit {
        unregister()
        
        if reachability != nil {
            reachability = nil
        }
    }
    
    // start listening for reachability notifications
    public func register() -> Bool {
        var returnValue = false
        
        var context = SCNetworkReachabilityContext(version: 0, info: nil, retain: nil, release: nil, copyDescription: nil)
        let setReturn = SCNetworkReachabilitySetCallback(reachability!, { (_, _, _) in
            Notification.Name.didUpdateNetworkStatus.post()
        }, &context)
        if setReturn {
            let scheduleReturn = SCNetworkReachabilityScheduleWithRunLoop(reachability!, CFRunLoopGetMain(), CFRunLoopMode.defaultMode.rawValue )
            if scheduleReturn {
                returnValue = true
            }
        }
        return returnValue
    }
    
    // stop listening for reachability notifications
    public func unregister() {
        if reachability != nil {
            SCNetworkReachabilityUnscheduleFromRunLoop(reachability!, CFRunLoopGetMain(), CFRunLoopMode.defaultMode.rawValue)
        }
    }
    
    // current reachability status
    public var currentStatus: NetworkStatus {
        
        if reachability == nil {
            return NetworkStatus.notReachable
        }
        
        var flags = SCNetworkReachabilityFlags(rawValue: 0)
        SCNetworkReachabilityGetFlags(reachability!, &flags)
        
        return networkStatus(flags: flags)
    }
    
    func networkStatus(flags: SCNetworkReachabilityFlags) -> NetworkStatus {
        if (flags & .reachable == 0) {
            // // The target host is not reachable.
            return NetworkStatus.notReachable
        }
        
        var returnValue = NetworkStatus.notReachable
        if flags & .connectionRequired == 0 {
            // If the target host is reachable and no connection is required
            // then we'll assume (for now) that you're on Wi-Fi...
            returnValue = NetworkStatus.reachableViaWiFi
        }
        
        if flags & .connectionOnDemand != 0 || flags & .connectionOnTraffic != 0 {
            
            // ... and the connection is on-demand (or on-traffic)
            // if the calling application is using the CFSocketStream or higher APIs...
            if flags & .interventionRequired == 0 {
                
                // ... and no [user] intervention is needed...
                returnValue = NetworkStatus.reachableViaWiFi
            }
        }
        
        if (flags & .isWWAN) == SCNetworkReachabilityFlags.isWWAN.rawValue {
            // ... but WWAN connections are OK if the calling application is using the CFNetwork APIs.
            returnValue = NetworkStatus.reachableViaWWAN
        }
        
        return returnValue
    }
}


//MARK: 'AND' functions
private func &(lhs: SCNetworkReachabilityFlags, rhs: SCNetworkReachabilityFlags) -> UInt32 {
    return lhs.rawValue & rhs.rawValue
}
