//
//  DispatchQueue+Once.swift
//  BBKit
//
//  Created by lk on 2023/2/17.
//

import UIKit

public extension DispatchQueue {
    private static var _onceTracker = [String]()
    
    /// 函数只被执行一次
    static func once(token: String, block: () -> ()) {
        if _onceTracker.contains(token) {
            return
        }
        objc_sync_enter(self)
        defer {
            objc_sync_exit(self)
        }
        _onceTracker.append(token)
        block()
    }
    
    static func mainAsync(do block: @escaping () -> ()) {
        if Thread.isMainThread {
            block()
        } else {
            DispatchQueue.main.async {
                DispatchQueue.mainAsync(do: block)
            }
        }
    }
}
