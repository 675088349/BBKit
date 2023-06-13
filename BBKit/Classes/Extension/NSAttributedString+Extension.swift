//
//  nsa.swift
//  BBKit
//
//  Created by 肥啊 on 2023/2/21.
//

import UIKit

public extension NSAttributedString {
    @objc class  func string(string: String,textColor:UIColor = UIColor.black, font: UIFont = .font(size: 14) ,lineSpacing: CGFloat = 10 ,space: CGFloat = 10 , alignment: NSTextAlignment = .justified) -> NSAttributedString {
       
        let pa:NSMutableParagraphStyle = NSMutableParagraphStyle()
        pa.lineSpacing =  lineSpacing
        pa.tailIndent = -space
        pa.headIndent = space
        pa.firstLineHeadIndent = space
        pa.maximumLineHeight = font.lineHeight -  font.leading
        pa.alignment = alignment
        
        let attributedString: NSAttributedString = NSAttributedString(string: string,
                                                                      attributes: [NSAttributedString.Key.font : font ,
                                                                                   NSAttributedString.Key.backgroundColor:UIColor.clear,
                                                                                   NSAttributedString.Key.foregroundColor:textColor,
                                                                                   NSAttributedString.Key.paragraphStyle:pa])
        return attributedString
    }
    
    func setShadow(radius: CGFloat = 1, offset: CGSize = CGSize.zero, color: UIColor = UIColor(hex: "000000", alpha: 0.3), rangeStr: String? = nil) -> NSMutableAttributedString {
        let attr = NSMutableAttributedString(attributedString: self)
        let str = rangeStr ?? self.string
        let shadow = NSShadow()
        shadow.shadowBlurRadius = radius
        shadow.shadowOffset = offset
        shadow.shadowColor = color
        let range = NSRange.init(location: 0, length: str.utf16.count)
        attr.addAttribute(.shadow, value: shadow, range: range)
        return attr
    }
}

