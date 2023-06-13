//
//  UIButton+Extension.swift
//  BBKit
//
//  Created by lk on 2023/2/17.
//

import UIKit

private var clickDelayTime = "clickDelayTime"
private var defaultDelayTime: TimeInterval = 0.0 //默认两次点击无间隔
private var lastClickTime: TimeInterval = 0.0 //记录上次点击时刻

public extension UIButton {
    
    static func getButton(frame:CGRect = .zero, image:UIImage?,  selectedImage:UIImage?) -> UIButton {
        return self.getButton(frame: frame, color: nil, image: image, selectedImage: selectedImage)
    }
    
    static func getButton(frame:CGRect = .zero, color: UIColor? = nil, textColor: UIColor = UIColor.black, text:String? = nil, font:UIFont?, image:UIImage? = nil) -> UIButton {
        return self.getButton(frame: frame, color: color, textColor: textColor, text: text, font: font, image: image, selectedImage: nil)
    }

    /// 快速创建一个按钮
    static func getButton(frame: CGRect = .zero, color: UIColor? = nil, textColor: UIColor? = UIColor.black, text:String? = nil, selectedText:String? = nil, selectedTextColor:UIColor? = nil, font:UIFont? = nil, image:UIImage? = nil, selectedImage:UIImage? = nil) -> UIButton {
        
        let btn = UIButton(type: .custom)
        btn.frame = frame
        if color != nil {
            btn.backgroundColor = color
        }
        btn.setTitle(text, for: .normal)
        btn.setTitleColor(textColor, for: .normal)
        btn.setImage(image, for: .normal)
        btn.titleLabel?.font = font
        btn.setTitle(selectedText, for: .selected)
        btn.setImage(selectedImage, for: .selected)
        btn.setTitleColor(selectedTextColor, for: .selected)
        return btn
    }
    
    /// 设置背景颜色
    func setBackgroundColor(color:UIColor, for state: UIControl.State) {
        self.setBackgroundImage(UIImage.from(color: color), for: state)
    }
    
    // 定义关联的Key
    private struct UIButtonKeys {
        static var clickKey = "UIButton+Extension+ActionKey"
    }
    
    /// 快速添加方法
    func addActionWithBlock(_ closure: @escaping (_ sender:UIButton)->()) {
       //把闭包作为一个值 先保存起来
       objc_setAssociatedObject(self, &UIButtonKeys.clickKey, closure, objc_AssociationPolicy.OBJC_ASSOCIATION_COPY)
       //给按钮添加传统的点击事件，调用写好的方法
       self.addTarget(self, action: #selector(actionForTapGesture), for: .touchUpInside)
    }
    
    @objc private func actionForTapGesture() {
      //获取闭包值
       let obj = objc_getAssociatedObject(self, &UIButtonKeys.clickKey)
       if let action = obj as? (_ sender:UIButton)->() {
          //调用闭包
          action(self)
       }
    }
    
    var delayTime: TimeInterval {
        set {
            objc_setAssociatedObject(self, &clickDelayTime, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        get {
            if let clickDelayTime = objc_getAssociatedObject(self, &clickDelayTime) as? TimeInterval {
                return clickDelayTime
            }
            return defaultDelayTime
        }
    }
    
    override func sendAction(_ action: Selector, to target: Any?, for event: UIEvent?) {
        // 未设置delayTime值或者设置为0s间隔
        if delayTime == 0 {
            super.sendAction(action, to: target, for: event)
        } else {
            // 两次点击时间间隔大于设定值，响应
            if Date().timeIntervalSince1970 - lastClickTime > delayTime {
                super.sendAction(action, to: target, for: event)
                // 更新本次点击时刻
                lastClickTime = Date().timeIntervalSince1970
            }
        }
    }
}

private var XHNUIButtonExpandSizeKey = "XHNUIButtonExpandSizeKey"
public extension UIControl {
    /// 扩大按钮点击区域 如UIEdgeInsets(top: -50, left: -50, bottom: -50, right: -15)将点击区域上下左右各扩充50
    var touchExtendInset: UIEdgeInsets {
        get {
            if let value = objc_getAssociatedObject(self, &XHNUIButtonExpandSizeKey) {
                var edgeInsets: UIEdgeInsets = UIEdgeInsets.zero
                (value as AnyObject).getValue(&edgeInsets)
                return edgeInsets
            } else {
                return UIEdgeInsets.zero
            }
        }
        set {
            objc_setAssociatedObject(self, &XHNUIButtonExpandSizeKey, NSValue(uiEdgeInsets: newValue), .OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
    }
    
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        if self.touchExtendInset == .zero || isHidden || !isEnabled {
            super.point(inside: point, with: event)
        }
        var hitFrame = bounds.inset(by: self.touchExtendInset)
        hitFrame.size.width = max(hitFrame.size.width, 0)
        hitFrame.size.height = max(hitFrame.size.height, 0)
        return hitFrame.contains(point)
    }
}
