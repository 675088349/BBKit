//
//  UIButton+Position.swift
//  BBKit
//
//  Created by lk on 2023/2/17.
//

import UIKit

public extension UIButton {
    
    enum PGButtonImageTitleStyle {
        case normal         ///<图片在左，文字在右，整体居中。
        case left           ///<图片在左，文字在右，整体居中。
        case right          ///<图片在右，文字在左，整体居中。
        case top            ///<图片在上，文字在下，整体居中。
        case bottom         ///<图片在下，文字在上，整体居中。
        case centerTop      ///<图片居中，文字在上距离按钮顶部。
        case centerBottom   ///<图片居中，文字在下距离按钮底部。
        case centerUp       ///<图片居中，文字在图片上面
        case centerDown     ///<图片居中，文字在图片下面。
        case rightLeft      ///<图片在右，文字在左，距离按钮两边边距
        case leftRight      ///<图片在左，文字在右，距离按钮两边边距
    }
    
    func setButtonImageTitleStyle(_ style: PGButtonImageTitleStyle, padding: CGFloat) {
        guard let imageView = self.imageView, let titleLabel = self.titleLabel else { return}
        
        if let _ = self.imageView?.image, let _ = self.titleLabel?.text {
            //先还原
            self.titleEdgeInsets = UIEdgeInsets.zero
            self.imageEdgeInsets = UIEdgeInsets.zero
            
            let imageRect = imageView.frame
            let titleRect = titleLabel.frame
//            imageRect.size = imageView.intrinsicContentSize
//            titleRect.size = titleLabel.intrinsicContentSize

            let totalHeight = imageRect.size.height + padding + titleRect.size.height
            let selfHeight = self.bb_size.height
            let selfWidth = self.bb_size.width

            switch style {
            case .left:
                if padding != 0 {
                    self.titleEdgeInsets = UIEdgeInsets(top: 0, left: padding/2, bottom: 0, right: -padding/2)
                    self.imageEdgeInsets = UIEdgeInsets(top: 0, left: -padding/2, bottom: 0, right: padding/2)
                }
            case .right:
                self.titleEdgeInsets = UIEdgeInsets(top: 0, left: -(imageRect.size.width + padding/2), bottom: 0, right: (imageRect.size.width + padding/2))
                self.imageEdgeInsets = UIEdgeInsets(top: 0, left: (titleRect.size.width + padding/2), bottom: 0, right: -(titleRect.size.width + padding/2))
            case .top:
                self.titleEdgeInsets = UIEdgeInsets(top: ((selfHeight - totalHeight) / 2 + imageRect.size.height + padding - titleRect.origin.y),
                                                    left: (selfWidth/2 - titleRect.origin.x - titleRect.size.width / 2) - (selfWidth - titleRect.size.width) / 2,
                                                    bottom: -((selfHeight - totalHeight) / 2 + imageRect.size.height + padding - titleRect.origin.y),
                                                    right: -(selfWidth / 2 - titleRect.origin.x - titleRect.size.width / 2) - (selfWidth - titleRect.size.width) / 2)
                self.imageEdgeInsets = UIEdgeInsets(top: ((selfHeight - totalHeight) / 2 - imageRect.origin.y),
                                                    left: (selfWidth / 2 - imageRect.origin.x - imageRect.size.width / 2),
                                                    bottom: -((selfHeight - totalHeight) / 2 - imageRect.origin.y),
                                                    right: -(selfWidth / 2 - imageRect.origin.x - imageRect.size.width / 2))
            case .bottom:
                self.titleEdgeInsets = UIEdgeInsets(top: ((selfHeight - totalHeight) / 2 - titleRect.origin.y),
                                                    left: (selfWidth / 2 - titleRect.origin.x - titleRect.size.width / 2) - (selfWidth - titleRect.size.width) / 2,
                                                    bottom: -((selfHeight - totalHeight) / 2 - titleRect.origin.y),
                                                    right: -(selfWidth / 2 - titleRect.origin.x - titleRect.size.width / 2) - (selfWidth - titleRect.size.width) / 2)
                self.imageEdgeInsets = UIEdgeInsets(top: ((selfHeight - totalHeight) / 2 + titleRect.size.height + padding - imageRect.origin.y),
                                                    left: (selfWidth / 2 - imageRect.origin.x - imageRect.size.width / 2),
                                                    bottom: -((selfHeight - totalHeight) / 2 + titleRect.size.height + padding - imageRect.origin.y),
                                                    right:  -(selfWidth / 2 - imageRect.origin.x - imageRect.size.width / 2))
            case .centerTop:
                self.titleEdgeInsets = UIEdgeInsets(top: -(titleRect.origin.y - padding),
                                                    left: (selfWidth / 2 -  titleRect.origin.x - titleRect.size.width / 2) - (selfWidth - titleRect.size.width) / 2,
                                                    bottom: (titleRect.origin.y - padding),
                                                    right: -(selfWidth / 2 -  titleRect.origin.x - titleRect.size.width / 2) - (selfWidth - titleRect.size.width) / 2)
                self.imageEdgeInsets = UIEdgeInsets(top: 0,
                                                    left: (selfWidth / 2 - imageRect.origin.x - imageRect.size.width / 2),
                                                    bottom: 0,
                                                    right:  -(selfWidth / 2 - imageRect.origin.x - imageRect.size.width / 2))
            case .centerUp:
                self.titleEdgeInsets = UIEdgeInsets(top: -(titleRect.origin.y + titleRect.size.height - imageRect.origin.y + padding),
                                                    left: (selfWidth / 2 -  titleRect.origin.x - titleRect.size.width / 2) - (selfWidth - titleRect.size.width) / 2,
                                                    bottom: (titleRect.origin.y + titleRect.size.height - imageRect.origin.y + padding),
                                                    right: -(selfWidth / 2 -  titleRect.origin.x - titleRect.size.width / 2) - (selfWidth - titleRect.size.width) / 2)
                self.imageEdgeInsets = UIEdgeInsets(top: 0,
                                                    left: (selfWidth / 2 - imageRect.origin.x - imageRect.size.width / 2),
                                                    bottom: 0,
                                                    right:  -(selfWidth / 2 - imageRect.origin.x - imageRect.size.width / 2))
            case .centerDown:
                self.titleEdgeInsets = UIEdgeInsets(top: (imageRect.origin.y + imageRect.size.height - titleRect.origin.y + padding),
                                                    left: (selfWidth / 2 -  titleRect.origin.x - titleRect.size.width / 2) - (selfWidth - titleRect.size.width) / 2,
                                                    bottom: -(imageRect.origin.y + imageRect.size.height - titleRect.origin.y + padding),
                                                    right: -(selfWidth / 2 -  titleRect.origin.x - titleRect.size.width / 2) - (selfWidth - titleRect.size.width) / 2)
                self.imageEdgeInsets = UIEdgeInsets(top: 0,
                                                    left: (selfWidth / 2 - imageRect.origin.x - imageRect.size.width / 2),
                                                    bottom: 0,
                                                    right:  -(selfWidth / 2 - imageRect.origin.x - imageRect.size.width / 2))
            case .rightLeft:
                self.titleEdgeInsets = UIEdgeInsets(top: 0,
                                                    left:  -(titleRect.origin.x - padding),
                                                    bottom: 0,
                                                    right: (titleRect.origin.x - padding))
                self.imageEdgeInsets = UIEdgeInsets(top: 0,
                                                    left: (selfWidth - padding - imageRect.origin.x - imageRect.size.width),
                                                    bottom: 0,
                                                    right:  -(selfWidth - padding - imageRect.origin.x - imageRect.size.width))
                
            case .leftRight:
                self.titleEdgeInsets = UIEdgeInsets(top: 0,
                                                    left:  (selfWidth - padding - titleRect.origin.x - titleRect.size.width),
                                                    bottom: 0,
                                                    right: -(selfWidth - padding - titleRect.origin.x - titleRect.size.width))
                self.imageEdgeInsets = UIEdgeInsets(top: 0,
                                                    left: -(imageRect.origin.x - padding),
                                                    bottom: 0,
                                                    right:  (imageRect.origin.x - padding))
            case .centerBottom:
                self.titleEdgeInsets = UIEdgeInsets(top: (selfHeight - padding - titleRect.origin.y - titleRect.size.height),
                                                    left: (selfWidth / 2 -  titleRect.origin.x - titleRect.size.width / 2) - (selfWidth - titleRect.size.width) / 2,
                                                    bottom: -(selfHeight - padding - titleRect.origin.y - titleRect.size.height),
                                                    right: -(selfWidth / 2 -  titleRect.origin.x - titleRect.size.width / 2) - (selfWidth - titleRect.size.width) / 2)
                self.imageEdgeInsets = UIEdgeInsets(top: 0,
                                                    left: (selfWidth / 2 - imageRect.origin.x - imageRect.size.width / 2),
                                                    bottom: 0,
                                                    right:  -(selfWidth / 2 - imageRect.origin.x - imageRect.size.width / 2))
            default:
                break
            }
        } else {
            self.titleEdgeInsets = UIEdgeInsets.zero
            self.imageEdgeInsets = UIEdgeInsets.zero
        }
    }
}
