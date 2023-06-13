//
//  ListenerEventObservable.swift
//  BBKit
//
//  Created by lk on 2023/2/17.
//

import Foundation

public protocol ListenerEventObservable {
    func startObserving()
    func stopObserving()
    
    func triggerEvent(_ event: EventProtocol)
}

extension ListenerEventObservable {
    public func startObserving() {}
    public func stopObserving() {}
    
    public func triggerEvent(_ event: EventProtocol) {}
}
