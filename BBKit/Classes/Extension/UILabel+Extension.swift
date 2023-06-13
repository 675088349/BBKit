//
//  UILabel+Extension.swift
//  BBKit
//
//  Created by 肥啊 on 2023/2/18.
//

import UIKit

extension UILabel {
    
    /**!
     return current Label's rect
     */
    public func boundingRect(with size: CGSize = CGSize(width: Double(MAXFLOAT), height: 0.0), options: NSStringDrawingOptions = [], attributes: [String : Any]? = nil, context: NSStringDrawingContext? = nil) -> CGRect? {
        let rect = self.text?.boundingRect(with: CGSize(width: Double(MAXFLOAT), height: 0.0), options: .usesLineFragmentOrigin, attributes: [.font: self.font!], context: nil)
        return rect
    }
    
    /**! return current Label.rect.size */
    public func boundingRectSize() -> CGSize {
        return self.boundingRect()?.size ?? CGSize.zero
    }
}

extension UILabel {
    //根据宽度动态计算高度(old)
    public func getLabelAttriHeight(width: CGFloat) -> CGFloat {
        guard let text = self.attributedText else { return 0 }
        let contentHeight = text.boundingRect(with: CGSize(width: width, height: CGFloat(MAXFLOAT)), options: [.usesLineFragmentOrigin], context: nil).height
        return contentHeight
    }
    
    // 根据宽度动态计算高度(new)
    public func getLabelHeight(width: CGFloat) -> CGFloat {
        return self.sizeThatFits(CGSize(width:width, height: CGFloat(MAXFLOAT))).height
    }
    
    //根据高度动态计算宽度(old)
    public func getLabelAttriWidth(height: CGFloat) -> CGFloat {
        guard let text = self.attributedText else { return 0 }
        let contentWidth = text.boundingRect(with: CGSize(width: CGFloat(MAXFLOAT), height: height), options: [.usesLineFragmentOrigin], context: nil).width
        return contentWidth
    }
    
    //根据高度动态计算宽度(new)
    public func getLabelWidth(height: CGFloat? = nil) -> CGFloat {
        return self.sizeThatFits(CGSize(width:CGFloat(MAXFLOAT), height: height ?? self.bb_height)).width
    }
}

public extension UILabel {
    /// 改变行间距
    /// - Parameter space: 行间距大小
    func changeLineSpace(space: CGFloat) {
        if self.text == nil || self.text == "" {
            return
        }
        let text = self.text
        let attributedString = NSMutableAttributedString(string: text!)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = space
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: .init(location: 0, length: text!.count))
        self.attributedText = attributedString
    }
}

public extension UILabel {
    /// 快速创建一个label
    static func getLabel(frame:CGRect = .zero, text:String? = nil, font:UIFont, color:UIColor? = .clear, textColor:UIColor, textAlignment:NSTextAlignment = .left) -> UILabel {
        let label = UILabel(frame: frame)
        label.textColor = textColor
        label.backgroundColor = color
        label.text = text
        label.textAlignment = textAlignment
        label.font = font
        
        return label
    }
}
