//
//  Listener.swift
//  BBKit
//
//  Created by lk on 2023/2/17.
//

import Foundation

open class ListenerCenter {
    private static let share = ListenerCenter()
    private var observers = NSHashTable<AnyObject>.weakObjects()

    private lazy var lock = NSRecursiveLock()
//    private var lastCheckNilObserversDate = Date()

//    fileprivate class ObserverHelper: NSObject {
//        weak var observer: ListenerEventObservable?
//        init(observer: ListenerEventObservable) {
//            super.init()
//            self.observer = observer
//        }
//    }

    /// 注册 event observer
    public static func register(_ observer: ListenerEventObservable) {
        share.lock.lock()
        defer { share.lock.unlock() }
        
//        if let _ = share.getHelper(of: observer) {
//            return
//        }
        if share.observers.contains(observer as AnyObject) {
            return
        }
        
        observer.startObserving()
        share.observers.add(observer as AnyObject)
//        let helper = ObserverHelper(observer: observer)
//        share.observers.insert(helper)
    }

    /// 注销 event observer
    public static func unregister(_ observer: ListenerEventObservable) {
        share.lock.lock()
        defer { share.lock.unlock() }
        
//        if let helper = share.getHelper(of: observer) {
        if share.observers.contains(observer as AnyObject) {
            observer.stopObserving()
            share.observers.remove(observer as AnyObject)
        }
    }

    public static func triggerEvent(_ event: EventProtocol) {
//        share.removeNilObservers()
//
//        share.observers.forEach {
//            $0.observer?.triggerEvent(event)
//        }
        for observer in share.observers.allObjects {
            if let observer = observer as? ListenerEventObservable {
                observer.triggerEvent(event)
            }
        }
    }
    
//    private func getHelper(of observer: ListenerEventObservable) -> ObserverHelper? {
//        return observers.first { observer.isEqual($0.observer)}
//    }
    
    /// 将 observer 已为 nil 的 helper 释放
//    private func removeNilObservers() {
//        let date = Date()
//
//        // 超过 10 分钟检查
//        if date.timeIntervalSince(lastCheckNilObserversDate) > 600 {
//            observers = observers.filter {
//                $0.observer != nil
//            }
//            lastCheckNilObserversDate = date
//        }
//    }
}
 
