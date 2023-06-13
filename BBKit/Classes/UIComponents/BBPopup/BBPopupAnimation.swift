////  BBPopupAnimation.swift
//  _idx_main_A77C1EB9_ios_min12.2
//
//  Created by lk on 2022/8/18.
//  Copyright © 2022 Bilibili. All rights reserved.
//

import UIKit

public class BBPopupAnimation: NSObject {
    static func present(with transitonContext: UIViewControllerContextTransitioning?, config: BBPopupConfig, contianerView: UIView, completion: ((_ isFinished: Bool) -> ())?) {
        let type = config.animationType
        switch type {
        case .bottomSheet:
            do {
                contianerView.frame.origin.y = KScreenHeight
                contianerView.layoutIfNeeded()
                contianerView.corner(byRoundingCorners: [.topLeft, .topRight], cornerRadii: config.cornerRadius)
                UIView.animate(withDuration: 0.25, animations: {
                    contianerView.frame.origin.y = KScreenHeight - contianerView.frame.size.height
                    contianerView.layoutIfNeeded()
                }) { (finished) in
                    transitonContext?.completeTransition(true)
                    completion?(finished)
                }
            }
            break
        case .topSheet:
            contianerView.frame.origin.y = -contianerView.bb_height
            contianerView.layoutIfNeeded()
            contianerView.corner(byRoundingCorners: [.bottomLeft, .bottomRight], cornerRadii: config.cornerRadius)
            UIView.animate(withDuration: 0.25, animations: {
                contianerView.frame.origin.y = 0
                contianerView.layoutIfNeeded()
            }) { (finished) in
                transitonContext?.completeTransition(true)
                completion?(finished)
            }
            
        case .center:
            do {
                contianerView.center = CGPoint(x: KScreenWidth / 2, y: KScreenHeight / 2)
                contianerView.layoutIfNeeded()
                let animation = CAKeyframeAnimation(keyPath: "transform")
                animation.duration = 0.25
                animation.isRemovedOnCompletion = true
                animation.fillMode = CAMediaTimingFillMode.forwards
                var values: [NSValue] = []
                values.append(NSValue.init(caTransform3D: CATransform3DMakeScale(0.9, 0.9, 1.0)))
                values.append(NSValue.init(caTransform3D: CATransform3DMakeScale(1.1, 1.1, 1.0)))
                values.append(NSValue.init(caTransform3D: CATransform3DMakeScale(1.0, 1.0, 1.0)))
                animation.values = values
                contianerView.layer.add(animation, forKey: nil)
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                    transitonContext?.completeTransition(true)
                    completion?(true)
                }
            }
            break
        }
    }
    
    static func dismiss(with transitonContext: UIViewControllerContextTransitioning?, config: BBPopupConfig, contianerView: UIView?, completion: ((_ isFinished: Bool) -> ())?) {
        let type = config.animationType
        switch type {
        case .bottomSheet:
            do {
                guard let _ = contianerView else {
                    transitonContext?.completeTransition(true)
                    completion?(true)
                    return
                }
                UIView.animate(withDuration: 0.25, animations: {
                    contianerView?.superview?.alpha = 0
                    contianerView?.frame.origin.y = KScreenHeight
                    contianerView?.layoutIfNeeded()
                }) { (finished) in
                    transitonContext?.completeTransition(true)
                    completion?(finished)
                }
            }
            break
        case .topSheet:
            guard let _ = contianerView else {
                transitonContext?.completeTransition(true)
                completion?(true)
                return
            }
            UIView.animate(withDuration: 0.25, animations: {
                contianerView?.superview?.alpha = 0
                contianerView?.frame.origin.y = -(contianerView?.bb_height ?? 0)
                contianerView?.layoutIfNeeded()
            }) { (finished) in
                transitonContext?.completeTransition(true)
                completion?(finished)
            }
        case .center:
            do {
                UIView.animate(withDuration: 0.25, animations: {
                    contianerView?.superview?.alpha = 0
                    contianerView?.alpha = 0
                }) { (finished) in
                    transitonContext?.completeTransition(true)
                    completion?(finished)
                }
            }
            break
        }
    }
}

