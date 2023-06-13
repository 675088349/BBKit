//
//  String+Extension.swift
//  BBKit
//
//  Created by 肥啊 on 2023/2/18.
//

import UIKit

public func StringFromClass(_ object: AnyObject) -> String {
    return NSStringFromClass(type(of: object)).components(separatedBy: ".").last! as String
}
public func ClassFromString(_ className: String) -> AnyClass! {
    
    if  let appName: String = Bundle.main.object(forInfoDictionaryKey: "CFBundleName") as! String? {
        // 过滤无效字符 空格不转换的话 得不到准确类名
        let formattedAppName = appName.replacingOccurrences(of: " ", with: "_")
        //拼接控制器名
        let classStringName = "\(formattedAppName).\(className)"
        //将控制名转换为类
        let classType: AnyClass? = NSClassFromString(classStringName)
        
        return classType
    }
    return nil
}

public extension String {
    func rangeOfString(string: String) -> NSRange {
        let range = (self as NSString).range(of: string)
        return range
    }
    
    ///根据宽度跟字体，计算文字的高度
    func textAutoHeight(width:CGFloat, font:UIFont) -> CGFloat{
        let string = self
        let origin = NSStringDrawingOptions.usesLineFragmentOrigin
        let lead = NSStringDrawingOptions.usesFontLeading
        let ssss = NSStringDrawingOptions.usesDeviceMetrics
        let rect = string.boundingRect(with:CGSize(width: width, height:0), options: [origin,lead,ssss], attributes: [NSAttributedString.Key.font:font], context:nil)
        return rect.height
    }
    
    ///根据高度跟字体，计算文字的宽度
    func textAutoWidth(height:CGFloat, font:UIFont) -> CGFloat{
        let string = self
        let origin = NSStringDrawingOptions.usesLineFragmentOrigin
        let lead = NSStringDrawingOptions.usesFontLeading
        let rect = string.boundingRect(with:CGSize(width:0, height: height), options: [origin,lead], attributes: [NSAttributedString.Key.font:font], context:nil)
        return rect.width
    }
    
    func toDictionary() -> [String : AnyObject]? {
        guard let data = self.data(using: String.Encoding.utf8) else {
            return nil
        }
        if let dict = try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as? [String : AnyObject] {
            return dict
        }
        return nil
    }
    
    var urlEscaped: String {
        addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }
    var utf8Encoded: Data { Data(self.utf8) }
    
    func getUrlParameters() -> [String: String]? {
        var params: [String: String] = [:]
        let array = self.components(separatedBy: "?")
        if array.count == 2 {
            let paramsStr = array[1]
            if paramsStr.count > 0 {
                let paramsArray = paramsStr.components(separatedBy: "&")
                for param in paramsArray {
                    let arr = param.components(separatedBy: "=")
                    if arr.count == 2 {
                        params[arr[0]] = arr[1]
                    }
                }
            }
        }

        return params
    }
    
    func parametersFromQueryString() -> [String: String]? {
        var params: [String: String] = [:]
        let array = self.components(separatedBy: "&")
        if array.count >= 2 {
            for item in array {
                let paramsArray = item.components(separatedBy: "=")
                if paramsArray.count == 2 {
                    params[paramsArray[0]] = paramsArray[1]
                }
            }
        }
        return params
    }
    
    /// 去除首位空格
    var removeHeadAndTailSpace:String {
        let whitespace = NSCharacterSet.whitespaces
        return self.trimmingCharacters(in: whitespace)
    }
    
    func setAttributedColor(color:UIColor, font:UIFont, rangeString:String, rangeColor:UIColor, rangeFont:UIFont) -> NSMutableAttributedString {
        guard self.count > 0 else {
            return NSMutableAttributedString(string: self)
        }
        
        let range = NSRange.init(location: 0, length: self.utf16.count)
        let strAttribute = NSMutableAttributedString(string: self)
        strAttribute.addAttribute(.foregroundColor, value: color, range: range)
        strAttribute.addAttribute(.font, value: font, range: range)
        
        if rangeString.count > 0 {
            let targetRange: NSRange = (self as NSString).range(of: rangeString as String)

            strAttribute.addAttribute(.foregroundColor, value: rangeColor, range: targetRange)
            strAttribute.addAttribute(.font, value: rangeFont, range: targetRange)
        }

        return strAttribute
    }
    
    func setAttributedColor(color:UIColor, font:UIFont, rangeStrings:[String], rangeColor:UIColor, rangeFont:UIFont) -> NSMutableAttributedString {
        guard self.count > 0 else {
            return NSMutableAttributedString(string: self)
        }
        
        let range = NSRange.init(location: 0, length: self.utf16.count)
        let strAttribute = NSMutableAttributedString(string: self)
        strAttribute.addAttribute(.foregroundColor, value: color, range: range)
        strAttribute.addAttribute(.font, value: font, range: range)

        for rangeString in rangeStrings {
            if rangeString.count > 0 {
                let targetRange: NSRange = (self as NSString).range(of: rangeString as String)
                strAttribute.addAttribute(.foregroundColor, value: rangeColor, range: targetRange)
                strAttribute.addAttribute(.font, value: rangeFont, range: targetRange)
            }
        }
        

        return strAttribute
    }
    
    func setShadow(radius: CGFloat = 1, offset: CGSize = CGSize.zero, color: UIColor = UIColor(hex: "000000", alpha: 0.3), rangeStr: String? = nil) -> NSMutableAttributedString {
        let attr = NSAttributedString(string: self)
        return attr.setShadow(radius: radius, offset: offset, color: color, rangeStr: rangeStr)
    }
}
