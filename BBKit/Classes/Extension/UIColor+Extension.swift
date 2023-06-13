//
//  UIColor+Extension.swift
//  BBKit
//
//  Created by 肥啊 on 2023/2/18.
//

import Foundation
import UIKit

public func BBColor(_ hex: String, _ alpha: CGFloat = 1.0) -> UIColor {
    return UIColor.init(hex: hex, alpha: alpha)
}

public extension UIColor {
    
    /// 通过16进制的字符串创建UIColor
    ///
    /// - Parameter hex: 16进制字符串，格式为#ececec
    convenience init (hex: String, alpha:CGFloat = 1.0) {
        let hex = (hex as NSString).trimmingCharacters(in: .whitespacesAndNewlines)
        let scanner = Scanner(string: hex)
        
        if hex.hasPrefix("#") {
            scanner.scanLocation = 1
        }
        
        var color: UInt32 = 0
        scanner.scanHexInt32(&color)
        
        let mask = 0x000000FF
        let r = Int(color >> 16) & mask
        let g = Int(color >> 8) & mask
        let b = Int(color) & mask
        
        let red   = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue  = CGFloat(b) / 255.0
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    
    /// 将UIColor转换为16进制字符串。
    func toHexString() -> String {
        let components = self.cgColor.components
        let r: CGFloat = components?[0] ?? 0.0
        let g: CGFloat = components?[1] ?? 0.0
        let b: CGFloat = components?[2] ?? 0.0
        
        let hexString = String(format: "#%02lX%02lX%02lX", lroundf(Float(r * 255)), lroundf(Float(g * 255)), lroundf(Float(b * 255)))
        return hexString
    }
}
