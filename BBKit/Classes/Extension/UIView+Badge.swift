//
//  UIView+Badge.swift
//  BBKit
//
//  Created by 肥啊 on 2023/2/18.
//

import UIKit

public extension UIView {
    
    static let badgeKey: UnsafeRawPointer! = UnsafeRawPointer.init(bitPattern: "BADGELABEL".hashValue)

    private var badgeLabel: UILabel {
        set {
            objc_setAssociatedObject(self, UIView.badgeKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        get {
            if let label = objc_getAssociatedObject(self, UIView.badgeKey) as? UILabel {
                return label
            }
            
            let label = UILabel.getLabel(font: UIFont.boldFont(size: 10), textColor: UIColor.white, textAlignment: .center)
            label.backgroundColor = .red
            label.frame = CGRect(x: 0, y: 0, width: 14, height: 14)
            self.addSubview(label)
            objc_setAssociatedObject(self, UIView.badgeKey, label, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            return label
        }
    }
    
    var badgeSize:CGSize {
        get {
            if badgeLabel.isHidden {
                return CGSize(width: 0, height: 0)
            }
            return badgeLabel.bb_size
        }
    }

    /// 添加 右上角 角标
    /// 如果clips = true badge将被添加到view的父视图上
    /// 如果auto = true badge 的 right或top 将等于 badge.width或height 除2 + offset
    func showBadge(num: String, offset: CGPoint = .zero, auto:Bool = false, clips:Bool = false) {
        self.badgeLabel.isHidden = false
        
        if num.count > 0 {
            self.badgeLabel.text = String(num)
            var width = self.badgeLabel.getLabelWidth()
            if width + 8 > 14 {
                width = width + 8
            } else {
                width = 14
            }
            self.badgeLabel.bb_width = width
            self.badgeLabel.roundedCorrner(radius: 7)
            self.badgeLabel.removeFromSuperview()
            
            var x = offset.x
            var y = offset.y
            if auto {
                x = width/2 + x
                y = -(self.badgeLabel.bb_height/2) + y
            }

            if clips, let supV = self.superview {
                supV.addSubview(self.badgeLabel)
                
                self.badgeLabel.bb_right = self.bb_right + x
                self.badgeLabel.bb_top = self.bb_top + y
            } else {
                self.addSubview(self.badgeLabel)
                
                self.badgeLabel.bb_right = self.bb_width + x
                self.badgeLabel.bb_top = y
            }
            
        } else {
            self.hiddenBadge()
        }
    }
    
    func showRedBadge(offset: CGPoint) {
        self.badgeLabel.text = ""
        self.badgeLabel.isHidden = false
        self.badgeLabel.bb_size = CGSize(width: 6, height: 6)
        self.badgeLabel.bb_right = self.bb_width + offset.x
        self.badgeLabel.bb_top = offset.y
        self.badgeLabel.roundedCorrner(radius: 3)
    }
    
    func hiddenBadge() {
        self.badgeLabel.isHidden = true
    }
}

