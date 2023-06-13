//
//  ListenerEventProtocol.swift
//  BBKit
//
//  Created by 肥啊 on 2023/2/17.
//

import Foundation

public protocol EventProtocol : Any {
    
    func type<T>(_ type: T) -> T?
}

public extension EventProtocol {
    
    func type<T>(_ type: T) -> T? {
        if let object = self as? T {
            return object
        }
        return nil
    }
}
