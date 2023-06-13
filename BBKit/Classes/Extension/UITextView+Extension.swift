//
//  UITextView+Extension.swift
//  BBKit
//
//  Created by 肥啊 on 2023/3/18.
//

import Foundation
import UIKit
// MARK: 提示：如果你想对textView.text直接赋值。请在设置属性之前进行，否则影响计算
// MARK:- 一、基本的扩展 (使用runtime添加属性)
public extension UITextView {
    // MARK: 1.1、设置占位符
    /// 设置占位符
    var placeholder: String? {
        set {
            objc_setAssociatedObject(self, UITextView.RuntimeKey.placeholder, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
            if self.placeHolderTextView != nil {
                self.placeHolderTextView?.text = placeholder
            }
        }
        get {
            return objc_getAssociatedObject(self, UITextView.RuntimeKey.placeholder) as? String
        }
    }
    // MARK: 1.2、限制的字数
    /// 限制的字数 (未测试)
    var limitLength: NSNumber? {
        set {
            objc_setAssociatedObject(self, UITextView.RuntimeKey.limitLength, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
        get {
            return objc_getAssociatedObject(self, UITextView.RuntimeKey.limitLength) as? NSNumber
        }
    }

    // MARK: 1.4、默认文本字体的大小
    /// 默认文本字体的大小
    var placeholdFont: UIFont? {
        set {
            objc_setAssociatedObject(self, UITextView.RuntimeKey.placeholdFont, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            if self.placeHolderTextView != nil {
                self.placeHolderTextView?.font = placeholdFont
            }
        }
        get {
            return objc_getAssociatedObject(self, UITextView.RuntimeKey.placeholdFont) as? UIFont == nil ? UIFont.systemFont(ofSize: 13) : objc_getAssociatedObject(self, UITextView.RuntimeKey.placeholdFont) as? UIFont
        }
    }
    // MARK: 1.5、默认文本的颜色
    /// 默认文本的颜色
    var placeholdColor: UIColor? {
        set {
            objc_setAssociatedObject(self, UITextView.RuntimeKey.placeholdColor, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            if self.placeHolderTextView != nil {
                self.placeHolderTextView?.textColor = placeholdColor
            }
        }
        get {
            return objc_getAssociatedObject(self, UITextView.RuntimeKey.placeholdColor) as? UIColor == nil ? UIColor.lightGray : objc_getAssociatedObject(self, UITextView.RuntimeKey.placeholdColor) as? UIColor
        }
    }
}
// MARK:- fileprivate 私有的内容
extension UITextView {
    fileprivate struct RuntimeKey {
        static let placeholder: UnsafeRawPointer! = UnsafeRawPointer.init(bitPattern: "PLACEHOLDEL".hashValue)
        static let limitLength: UnsafeRawPointer! = UnsafeRawPointer.init(bitPattern: "LIMITLENGTH".hashValue)
        static let limitLines: UnsafeRawPointer! = UnsafeRawPointer.init(bitPattern: "LIMITLINES".hashValue)
        static let placeholderLabel: UnsafeRawPointer! = UnsafeRawPointer.init(bitPattern: "PLACEHOLDELABEL".hashValue)
        static let placeholdFont: UnsafeRawPointer! = UnsafeRawPointer.init(bitPattern: "PLACEHOLDFONT".hashValue)
        static let placeholdColor: UnsafeRawPointer! = UnsafeRawPointer.init(bitPattern: "PLACEHOLDCOLOR".hashValue)
        // ...其他Key声明
    }

    /// 默认文本
    fileprivate var placeHolderTextView: UITextView? {
        set {
            objc_setAssociatedObject(self, UITextView.RuntimeKey.placeholderLabel, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        get {
            if let placeholderLabel = objc_getAssociatedObject(self, UITextView.RuntimeKey.placeholderLabel) as? UITextView {
//                placeholderLabel.text =
                return placeholderLabel
            }
            
            NotificationCenter.default.addObserver(self, selector: #selector(textChange(notif:)), name: UITextView.textDidChangeNotification, object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(textDidBegin(notif:)), name: UITextView.textDidBeginEditingNotification, object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(textDidEnd(notif:)), name: UITextView.textDidEndEditingNotification, object: nil)
            
            let placeholderLabel = UITextView(frame: self.bounds)
            placeholderLabel.font = self.placeholdFont
            placeholderLabel.text = placeholder
            placeholderLabel.textColor = self.placeholdColor
            placeholderLabel.backgroundColor = UIColor.clear
            placeholderLabel.isUserInteractionEnabled = false
            self.addSubview(placeholderLabel)
            objc_setAssociatedObject(self, UITextView.RuntimeKey.placeholderLabel, placeholderLabel, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)

            placeholderLabel.isHidden = self.text.count > 0
            return placeholderLabel
        }
    }
    
    @objc func textChange(notif: Notification) {
        let textView = notif.object as! UITextView
        let text = textView.text ?? ""
        
        guard textView == self else { return }
        
        if text.count > 0 {
            self.placeHolderTextView?.isHidden = true
        } else {
            self.placeHolderTextView?.isHidden = false
        }
        
        if let limitLength = self.limitLength {
            if textView.text.count > limitLength.intValue {
                let allString = textView.text + text
                textView.text = String(allString.prefix(limitLength.intValue))
            }
        }
    }
    
    @objc func textDidBegin(notif: Notification) {
        let textView = notif.object as! UITextView

        if textView == self {
            self.placeHolderTextView?.frame = self.bounds
        }
    }
    
    @objc func textDidEnd(notif: Notification) {
        let textView = notif.object as! UITextView
        
        if textView == self {
            if (textView.text == "") {
                self.placeHolderTextView?.isHidden = false
            }
        }
    }
}

