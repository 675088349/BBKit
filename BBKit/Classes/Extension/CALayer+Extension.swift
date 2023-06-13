//
//  CALayer+Extension.swift
//  BBKit
//
//  Created by 肥啊 on 2023/2/17.
//

import UIKit

extension CALayer {
    
    public func addBorder(edge: UIRectEdge, color: UIColor, width: CGFloat) {
        let border = CALayer()
        switch edge {
        case UIRectEdge.top:
            border.frame = CGRect.init(x: 0, y: 0, width: frame.width, height: width)
            break
        case UIRectEdge.bottom:
            border.frame = CGRect.init(x: 0, y: frame.height - width, width: frame.width, height: width)
            break
        case UIRectEdge.left:
            border.frame = CGRect.init(x: 0, y: 0, width: width, height: frame.height)
            break
        case UIRectEdge.right:
            border.frame = CGRect.init(x: frame.width - width, y: 0, width: width, height: frame.height)
            break
        default:
            break
        }
        border.backgroundColor = color.cgColor;
        self.addSublayer(border)
    }
}
