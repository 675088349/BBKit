//
//  View+MBProgressHUD.swift
//  BBKit
//
//  Created by 肥啊 on 2023/2/21.
//

import UIKit

var LoadingViewShowing: Bool = false
let LoadingViewTag: Int = 19980

public extension UIView {
    
    @objc func showLoading() {
        self.showLoading(message: nil)
    }
    
    @objc func showLoading(message:String?) {
        if LoadingViewShowing == true {return}
        if Thread.isMainThread {
            let bgView = UIView(frame:self.bounds)
            bgView.tag = LoadingViewTag
            bgView.backgroundColor = UIColor.clear
            let containerFrame = CGRect(x: (KScreenWidth - 72)/2, y: (KScreenHeight - 64)/2, width: 72, height: 64)
            let container = UIView(frame: containerFrame);
            container.backgroundColor = UIColor(hex: "212121", alpha: 0.8)
            container.cornerAllRound(cornerRadii: 4)
            bgView.addSubview(container)
            container.frame = UIApplication.shared.keyWindow?.convert(containerFrame, to: self) ?? containerFrame
            let imageView = UIImageView(frame: CGRect(x: 25, y: message == nil ? 21 : 10.5, width: 22, height: 22))
            imageView.showLoading()
            container.addSubview(imageView)
        
            if message != nil {
                let messageL = UILabel.getLabel(text: message, font: .font(size: 12), textColor: .white)
                messageL.textAlignment = .center
                messageL.frame = CGRect(x: 6, y: imageView.frame.maxY + 7, width: 60, height: 15)
                messageL.backgroundColor = UIColor.clear
                container.addSubview(messageL)
            }
            LoadingViewShowing = true
            self.addSubview(bgView)
            DispatchQueue.main.asyncAfter(deadline: .now() + 8) {
                if LoadingViewShowing {
                    self.hideLoading()
                }
            }
        } else {
            DispatchQueue.main.async {
                self.showLoading(message: message)
            }
        }
    }
    
    @objc func hideLoading() {
        if Thread.isMainThread {
            LoadingViewShowing = false
            self.viewWithTag(LoadingViewTag)?.removeFromSuperview()
        } else {
            DispatchQueue.main.async {
                self.hideLoading()
            }
        }
    }
    
}

public func BBShowHUD () {
    if Thread.isMainThread {
        UIApplication.shared.keyWindow?.showLoading()
    } else {
        DispatchQueue.main.async {
            BBHideHUD()
        }
    }
}

public func BBHideHUD() {
    if Thread.isMainThread {
        UIApplication.shared.keyWindow?.hideLoading()
    } else {
        DispatchQueue.main.async {
            BBHideHUD()
        }
    }
}

public extension UIImageView {
    
    @objc override func showLoading() {
        let images = ["0","1","2","3","4","5","6","7","8","9","10","11","12","13","15","16","17","18","19"].compactMap{UIImage.load_image(name: String("icon_loading_" + $0))}
        self.showLoading(images: images)
    }
    
    @objc func showLoading(images:[UIImage]) {
        if self.isAnimating {return}
        self.animationImages = images
        self.animationDuration = 1.0
        DispatchQueue.mainAsync {
            self.startAnimating()
        }
    }
    
    @objc override func hideLoading() {
        DispatchQueue.mainAsync {
            self.stopAnimating()
        }
    }
}
