
//
//  Notification+Extention.swift
//  Networker
//

import Foundation

public extension Notification.Name {
    func add(_ observer: Any, selector: Selector, object: Any? = nil) {
        NotificationCenter.default.addObserver(observer, selector: selector, name: self, object: object)
    }
    
    func post(object: Any? = nil, userInfo: [AnyHashable: Any]? = nil) {
        NotificationCenter.default.post(name: self, object: object, userInfo: userInfo)
    }
    
    func remove(_ observer: Any, object: Any? = nil) {
        NotificationCenter.default.removeObserver(observer, name: self, object: object)
    }
}

public extension Notification.Name {
    static let didUpdateNetworkStatus = Notification.Name("network_status_updated")
}
