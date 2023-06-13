//
//  UIViewController+MBProgressHUD.swift
//  BBKit
//
//  Created by 肥啊 on 2023/2/21.
//

import UIKit

public extension UIViewController {
    @objc func makeHudToast(message: String) {
        self.makeHudToast(message: message, after: 2)
    }
    @objc func makeHudToast(message: String,after: Int) {
        DispatchQueue.main.async {
        
            let attributedString = NSAttributedString.string(string: message, font: UIFont.font(size: 14), lineSpacing: 6, space: 0, alignment: .center)
            let size = attributedString.boundingRect(with: CGSize(width: 172, height: Int.max), options: NSStringDrawingOptions(rawValue: NSStringDrawingOptions.usesFontLeading.rawValue | NSStringDrawingOptions.usesLineFragmentOrigin.rawValue), context: nil).size
            let toastLabel = UILabel.getLabel(frame: CGRect(x: 24, y: 0, width: size.width, height: size.height + 27), font: UIFont.font(size: 14), color: UIColor.white, textColor: UIColor.black)
            toastLabel.attributedText = attributedString
            toastLabel.textColor = UIColor.white
            toastLabel.backgroundColor = UIColor.clear
            toastLabel.textAlignment = .center
            toastLabel.numberOfLines = 0
            let contentView = UIView(frame: CGRect(x: (UIScreen.main.bounds.width - toastLabel.frame.width - 48)/2, y: (UIScreen.main.bounds.height - toastLabel.frame.height - 48)/2, width: toastLabel.frame.width + 48, height: toastLabel.frame.height))
            contentView.backgroundColor = UIColor(hex: "212121", alpha: 0.8)
            contentView.cornerAllRound(cornerRadii: 4)
            contentView.addSubview(toastLabel)
        
            let containerView = UIView(frame: UIScreen.main.bounds)
            containerView.backgroundColor = UIColor.clear
            containerView.addSubview(contentView);
            UIApplication.shared.keyWindow?.addSubview(containerView);
            DispatchQueue.main.asyncAfter(deadline:.now() + .seconds(after)) {
                containerView.removeFromSuperview()
            }
        }
    }
    @objc func showLoading() {
        self.showLoading(message: nil)
    }
    
    @objc func showLoading(message: String?) {
        self.view.showLoading(message: message)
    }
    
    @objc func hideLoading(){
        self.view.hideLoading()
    }
}
