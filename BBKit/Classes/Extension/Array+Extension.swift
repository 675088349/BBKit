//
//  Array+Extension.swift
//  BBKit
//
//  Created by lk on 2023/2/17.
//

import UIKit

extension Array {
    
    public func toString() -> String {
        guard self.count > 0 else {
            return ""
        }
        guard let array = self as? [String] else {
            return ""
        }
        return "[\"" + array.joined(separator: "\",\"") + "\"]"
    }
    
    public var last: Element? {
        get {
            return self.getValue(at: self.count - 1)
        }
    }
    
    public func getValue(at index: Int) -> Element? {
        guard index >= 0 && index < self.count else {
            return nil
        }
        return self[index]
    }
    
    @discardableResult
    mutating public func xhn_insert(_ item: Element, index: Int) -> Bool {
        if index > self.count {
            return false
        }
        
        self.insert(item, at: index)
        return true
    }
    
    @discardableResult
    mutating public func xhn_remove(at index: Int) -> Element? {
        if index > self.count {
            return nil
        }
        
        return self.remove(at: index)
    }
    
    mutating public func replace(at index: Int, element: Element) {
        if index >= 0, index < self.count {
            self[index] = element
        }
    }
    
    public func firstValue() -> Element? {
        guard self.count > 0 else {
            return nil
        }
        return self[0]
    }
    
    /// 从数组中返回一个随机元素
    public var random: Element? {
        //如果数组为空，则返回nil
        guard count > 0 else { return nil }
        let randomIndex = Int(arc4random_uniform(UInt32(count)))
        return self[randomIndex]
    }
}

extension Array where Element : Equatable {
    public func indexOfObject(_ item: Element) -> Int? {
        for (index, value) in self.enumerated() where value == item {
            return index
        }
        return nil
    }
}
