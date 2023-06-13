//
//  UIFont+Extension.swift
//  BBKit
//
//  Created by 肥啊 on 2023/2/18.
//

import UIKit

public extension UIFont {
    static func font(size: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: size)
    }
    
    static func boldFont(size: CGFloat) -> UIFont {
        return UIFont.boldSystemFont(ofSize: size)
    }
    
    static func boldItalicFont(size: CGFloat) -> UIFont {
        return UIFont.italicSystemFont(ofSize: size)
    }
    
    static func nunitoBoldFont(size: CGFloat) -> UIFont {
        return UIFont.italicSystemFont(ofSize: size)
    }
}

public func RegularFont(_ size: CGFloat) -> UIFont {
    return UIFont.systemFont(ofSize: size, weight: .regular)
}

public func BoldFont(_ size: CGFloat) -> UIFont {
    return UIFont.systemFont(ofSize: size, weight: .bold)
}

public func MediumFont(_ size: CGFloat) -> UIFont {
    return UIFont.systemFont(ofSize: size, weight: .medium)
}

public func SemiboldFont(_ size: CGFloat) -> UIFont {
    return UIFont.systemFont(ofSize: size, weight: .semibold)
}
