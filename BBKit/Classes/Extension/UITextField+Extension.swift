//
//  UITextField+Extension.swift
//  BBKit
//
//  Created by 肥啊 on 2023/2/18.
//

import UIKit
 
private var XHNTextFieldPlaceholderColor = "XHNTextFieldPlaceholderColor"
private var XHNTextFieldPlaceholderFont = "XHNTextFieldPlaceholderFont"

extension UITextField {
 
    public var placeholderColor: UIColor? {
        get {
            if let value = objc_getAssociatedObject(self, &XHNTextFieldPlaceholderColor) as? UIColor {
                return value
            } else {
                return nil
            }
        }
        set {
            if let newValue = newValue {
                self.attributedPlaceholder = NSAttributedString(string: self.placeholder.unwraps, attributes: [NSAttributedString.Key.foregroundColor: newValue])
                objc_setAssociatedObject(self, &XHNTextFieldPlaceholderColor, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
            }
        }
    }
    
    public var placeholderFont: UIFont? {
        get {
            if let value = objc_getAssociatedObject(self, &XHNTextFieldPlaceholderColor) as? UIFont {
                return value
            } else {
                return nil
            }
        }
        set {
            if let newValue = newValue {
                self.attributedPlaceholder = NSAttributedString(string: self.placeholder.unwraps, attributes: [NSAttributedString.Key.font: newValue])
                objc_setAssociatedObject(self, &XHNTextFieldPlaceholderColor, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
            }
        }
    }
    
    /// 添加左内边距
    public func addLeftTextPadding(_ blankSize: CGFloat) {
        let leftView = UIView()
        leftView.frame = CGRect(x: 0, y: 0, width: blankSize, height: frame.height)
        self.leftView = leftView
        self.leftViewMode = UITextField.ViewMode.always
    }
 
    /// 在文本框的左边添加一个图标
    public func addLeftIcon(_ image: UIImage?, frame: CGRect, imageSize: CGSize) {
        let leftView = UIView()
        leftView.frame = frame
        let imgView = UIImageView()
        imgView.frame = CGRect(x: frame.width - 8 - imageSize.width, y: (frame.height - imageSize.height) / 2, width: imageSize.width, height: imageSize.height)
        imgView.image = image
        leftView.addSubview(imgView)
        self.leftView = leftView
        self.leftViewMode = UITextField.ViewMode.always
    }
 
}
