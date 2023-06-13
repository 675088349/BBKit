//
//  UIAleat+Extension.swift
//  BBKit
//
//  Created by 肥啊 on 2023/3/13.
//

import UIKit

public extension UIAlertController {
    typealias UIAlertActionHandel = (_ index: Int, _ action: UIAlertAction)->()
    typealias UIAlertActonCancelBlock = ()->()
    
    static func showAlert(_ title: String? = "",
                   message: String? = "",
                   actionAry: [String],
                   cancel: String? = nil,
                   tintColor: UIColor? = nil,
                   style: UIAlertController.Style = .alert,
                   actionHandel:UIAlertActionHandel? = nil,
                   cancelHandel: UIAlertActonCancelBlock? = nil
    ) {
        let alert = UIAlertController.init(title: title, message: message, preferredStyle: style)
        if let tintColor = tintColor {
            alert.view.tintColor = tintColor
        }
        
        for (index,text) in actionAry.enumerated() {
            let alertAction = UIAlertAction(title: text, style: .default) { action in
                actionHandel?(index, action)
            }
            alert.addAction(alertAction)
        }
        
        if let cancel = cancel {
            let cancelAction = UIAlertAction(title: cancel, style: .cancel) { action in
                cancelHandel?()
            }
            alert.addAction(cancelAction)
        }
        
        UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true)
    }
    
    
}
