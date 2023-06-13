////  PGPopupController.swift
//  _idx_main_A77C1EB9_ios_min12.2
//
//  Created by lk on 2022/8/18.
//  Copyright © 2022 Bilibili. All rights reserved.
//

import UIKit

public protocol BBPopupProtocol: AnyObject {
    /// 遵循使用weak
    var popupViewControl: BBPopupController? { get set }
}

@objc public enum BBPopupAnimationType: Int {
    case center
    case bottomSheet
    case topSheet
}

public struct BBPopupConfig {
    public var bgColor: UIColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.4)
    /// 点击背景是否隐藏
    public var isDismissible = true
    /// 动画类型
    public var animationType: BBPopupAnimationType = .bottomSheet
    
    public var cornerRadius:CGFloat = 20
}

public class BBPopupController: UIViewController, UIGestureRecognizerDelegate {

    var isShow = false
    
    weak var transitionContext: UIViewControllerAnimatedTransitioning?

    public var container: UIView?

    public var config: BBPopupConfig = BBPopupConfig()

    init(with config: BBPopupConfig = BBPopupConfig(), container: (() -> UIView)?) {
        super.init(nibName: nil, bundle: nil)
        self.transitionContext = self
        self.container = container?()
        self.config = config
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.setNavigationBarHidden(true, animated: false)

        if let container = self.container {
            if let subview = container as? BBPopupProtocol {
                subview.popupViewControl = self
            }
            self.view.addSubview(container)
        }

        self.view.backgroundColor = self.config.bgColor
        let tapGest = UITapGestureRecognizer(target: self, action: #selector(tapBGAction))
        tapGest.delegate = self
        self.view.addGestureRecognizer(tapGest)
    }
    

    func show(with vc: UIViewController) {
        let navi = UINavigationController.init(rootViewController: self)
        navi.transitioningDelegate = self
        navi.modalPresentationStyle = .custom
        self.isShow = true
        vc.present(navi, animated: true) {
        }
    }

    @objc func tapBGAction() {
        guard self.config.isDismissible else { return }
        self.closeVC(with: nil)
    }
    
    func closeVC(with completion: (() -> Void)?) {
        self.dismiss(animated: true, completion: completion)
    }
    
    public override func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
        self.isShow = false
        super.dismiss(animated: flag, completion: completion)
    }
    
    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        let isTapGest = gestureRecognizer is UITapGestureRecognizer
        let point = gestureRecognizer.location(in: gestureRecognizer.view)
        let rect = self.container?.frame ?? .zero
        let inContianer = rect.contains(point)
        if isTapGest {
            if inContianer {
                return false
            }
            if self.config.isDismissible == false {
                return false
            }
        } else {
            if self.config.isDismissible == false {
                return false
            }
        }
        return true
    }
    
    deinit {
        print("\(NSStringFromClass(type(of: self))) did deinit")
    }
}

extension BBPopupController: UIViewControllerTransitioningDelegate,UIViewControllerAnimatedTransitioning {
    
    public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.25
    }
    
    public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self.transitionContext
    }
    
    public func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self.transitionContext
    }
    
    public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        if self.isShow == true {
            self.present(transitonContext: transitionContext)
        } else {
            self.dismiss(transitonContext: transitionContext)
        }
    }

    func present(transitonContext: UIViewControllerContextTransitioning) {
        let toNavi: UINavigationController = transitonContext.viewController(forKey:.to) as! UINavigationController
        let containerView = transitonContext.containerView
        containerView.addSubview(toNavi.view)
        guard let contianerView = self.container else {
            transitonContext.completeTransition(true)
            return
        }
        
        BBPopupAnimation.present(with: transitonContext, config: self.config, contianerView: contianerView) { isFinished in
        }
    }

    func dismiss(transitonContext: UIViewControllerContextTransitioning) {
        BBPopupAnimation.dismiss(with: transitonContext, config: self.config, contianerView: self.container, completion: nil)
    }
}
