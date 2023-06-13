//
//  Data.swift
//  BBKit
//
//  Created by lk on 2023/2/17.
//

import Foundation

public extension Data {
    func dataToDictionary() ->Dictionary<String, Any>?{
        do{
            let json = try JSONSerialization.jsonObject(with: self, options: .mutableContainers)
            let dic = json as! Dictionary<String, Any>
            return dic
        }catch _ {
            return nil
        }
    }
}
