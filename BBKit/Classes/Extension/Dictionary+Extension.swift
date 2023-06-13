//
//  Dictionary.swift
//  BBKit
//
//  Created by lk on 2023/2/17.
//

import UIKit

public extension Dictionary {
    
    func toString() -> String?{
        guard let data = try? JSONSerialization.data(withJSONObject: self, options: []) else {
            return nil
        }
        return String(data: data, encoding: String.Encoding.utf8)
     }
     
     mutating func set(_ key : Dictionary.Key , _ value : Dictionary.Value?) {
         if let o = value {
             self[key] =  o
         } else {
             print("Warning! Dictionary:\(self) append an nil value key is '\(key)'")
         }
     }
}
