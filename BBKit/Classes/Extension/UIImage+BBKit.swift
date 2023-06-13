//
//  UIImage+BBKit.swift
//  BBKit
//
//  Created by 肥啊 on 2023/2/21.
//

import Foundation
import UIKit

extension UIImage {
    
    static func load_image(name: String) -> UIImage? {
        return bundle_image(bundle: "BBKit", name: name)
    }
    
    public static func bundle_image(bundle: String, name: String) -> UIImage? {
        return commonLoadImage(name: name, in: bundle)
    }
    
    fileprivate static func commonLoadImage(name: String, in pathComponent: String) -> UIImage? {
        guard let resourcePath: String = Bundle.main.resourcePath else { return nil }
        let bundlePath = resourcePath + "/\(pathComponent).bundle"
        let bundle = Bundle(path: bundlePath)
        return UIImage(named: name, in: bundle, compatibleWith: nil)
    }
    
    
    public func imageChangeColor( _ color:UIColor) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
        let context = UIGraphicsGetCurrentContext()
        context?.translateBy(x: 0, y: self.size.height)
        context?.scaleBy(x: 1.0, y: -1.0)
        context?.setBlendMode(CGBlendMode.normal)
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        context?.clip(to: rect, mask: self.cgImage!)
        color.setFill()
        context?.fill(rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
        
    }
}
