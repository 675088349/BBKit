////  BBPopup.swift
//  _idx_main_A77C1EB9_ios_min12.2
//
//  Created by lk on 2022/8/18.
//  Copyright © 2022 Bilibili. All rights reserved.
//

import UIKit

/// ！如果写成属性会造成循环引用
public struct BBPopup<Base> {
    public let base: Base
    public init(_ base: Base) {
        self.base = base
    }
}

extension BBPopup where Base: UIViewController {
    
    public func bottomSheet(with isDismissible: Bool = true, cornerRadius: CGFloat = 20, bgColor: UIColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.4), container: () -> UIView) {
        var config: BBPopupConfig = BBPopupConfig()
        config.animationType = .bottomSheet
        config.isDismissible = isDismissible
        let view = container()
        let vc = BBPopupController(with: config) {
            view
        }
        vc.show(with: base)
    }
    
    public func topSheet(with isDismissible: Bool = true, cornerRadius: CGFloat = 20, bgColor: UIColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.4), container: () -> UIView) {
        var config: BBPopupConfig = BBPopupConfig()
        config.animationType = .topSheet
        config.isDismissible = isDismissible
        config.cornerRadius = cornerRadius
        let view = container()
        let vc = BBPopupController(with: config) {
            view
        }
        vc.show(with: base)
    }
    
    public func centerSheet(with isDismissible: Bool = true, cornerRadius: CGFloat = 20, bgColor: UIColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.4), container: () -> UIView) {
        var config: BBPopupConfig = BBPopupConfig()
        config.animationType = .center
        config.isDismissible = isDismissible
        config.cornerRadius = cornerRadius
        let view = container()
        let vc = BBPopupController(with: config) {
            view
        }
        vc.show(with: base)
    }
    
    public func dismissPopup() {
        if let navi = base.presentedViewController as? UINavigationController, let vc = navi.viewControllers.first as? BBPopupController {
            vc.closeVC(with: nil)
        }
    }
}
