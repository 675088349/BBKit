//
//  Bundle+Extension.swift
//  BBKit
//
//  Created by lk on 2023/2/21.
//

import Foundation

extension Bundle {
    
    /// 获取bundle的
    public static func bundlePath(bundleName: String) -> Bundle? {
        guard let resourcePath: String = Bundle.main.resourcePath else { return nil }
        let bundlePath = resourcePath + "/\(bundleName)"
        let bundle = Bundle(path: bundlePath)
        return bundle
    }
}

