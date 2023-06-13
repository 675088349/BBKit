//
//  UIView+Extension.swift
//  BBKit
//
//  Created by 肥啊 on 2023/2/18.
//

import UIKit

extension UIView {
    
    /// 快速创建一个view
    static public func getView(frame: CGRect = .zero, color: UIColor? = nil) -> UIView {
        let view = UIView(frame: frame)
        view.backgroundColor = color
        return view
    }
    
    public func corner(byRoundingCorners corners:UIRectCorner, cornerRadii: CGFloat) {
        self.layoutIfNeeded()
        let maskPath = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: cornerRadii, height: 0.0))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = self.bounds
        maskLayer.path = maskPath.cgPath
        self.layer.mask = maskLayer
     }
    
     public func corner(byRoundingCorners corners:UIRectCorner, cornerRadii: CGFloat, shadowColor: UIColor, shadowRadius: CGFloat, shadowOpacity: Float, shadowOffset: CGSize) {
         
         self.layer.shadowColor = shadowColor.cgColor
         self.layer.shadowOpacity = shadowOpacity
         self.layer.shadowRadius =  shadowRadius
         self.layer.shadowOffset = shadowOffset
         self.layer.cornerRadius = cornerRadii
         
         self.layer.shadowPath =    UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: cornerRadii, height: cornerRadii)).cgPath
     }
     
     public func corner(byRoundingCorners corners:UIRectCorner, cornerRadii: CGFloat, borderColor: UIColor, borderWidth: CGFloat) {
         let maskPath = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: cornerRadii, height: cornerRadii))
         let tempLayer = CAShapeLayer()
         tempLayer.lineWidth = borderWidth
         tempLayer.fillColor = UIColor.clear.cgColor
         tempLayer.strokeColor = borderColor.cgColor
         tempLayer.frame = self.bounds
         tempLayer.path = maskPath.cgPath
         self.layer.addSublayer(tempLayer)
         
         let maskLayer = CAShapeLayer()
         maskLayer.frame = self.bounds
         maskLayer.path = maskPath.cgPath
         self.layer.mask = maskLayer
      }
     
    public func cornerAllRound(cornerRadii: CGFloat) {
         self.corner(byRoundingCorners: UIRectCorner.allCorners, cornerRadii: cornerRadii)
     }
    
    /// clipsToBounds
    public func roundedCorrner(radius: CGFloat, clipsToBounds: Bool = true) {
        self.layer.cornerRadius = radius
        self.clipsToBounds = clipsToBounds
    }
    
    public func roundedRectangleFilter() {
        self.roundedCorrner(radius: self.bb_height / 2)
    }
    
    public func circleFilter() {
        self.roundedCorrner(radius: self.bb_width / 2)
    }
    
    public func border(width: CGFloat, color: UIColor) {
        self.layer.borderWidth = width
        self.layer.borderColor = color.cgColor
        self.layer.masksToBounds = true
    }
    
    public func removeSublayers() {
        if let sublayers = self.layer.sublayers {
            for layer in sublayers {
                layer.removeFromSuperlayer()
            }
        }
    }
    
    public func removeAllSubviews() {
        for view in self.subviews {
            view.removeFromSuperview()
        }
    }
    
    public func hasViewClass(targetClass: AnyClass) -> Bool {
        for childView in self.subviews {
            if childView.isMember(of: targetClass) {
                return true
            }
        }
        return false
    }
    
    public func addSubViews(subviews: [UIView]) {
        for subview in subviews {
            self.addSubview(subview)
        }
    }
}

extension UIView {
    //画线
    private func drawBorder(rect:CGRect,color:UIColor){
        let line = UIBezierPath(rect: rect)
        let lineShape = CAShapeLayer()
        lineShape.path = line.cgPath
        lineShape.fillColor = color.cgColor
        self.layer.addSublayer(lineShape)
    }
    
    //设置右边框
    public func rightBorder(width:CGFloat,borderColor:UIColor){
        let rect = CGRect(x: 0, y: self.frame.size.width - width, width: width, height: self.frame.size.height)
        drawBorder(rect: rect, color: borderColor)
    }
    //设置左边框
    public func leftBorder(width:CGFloat,borderColor:UIColor){
        let rect = CGRect(x: 0, y: 0, width: width, height: self.frame.size.height)
        drawBorder(rect: rect, color: borderColor)
    }
    
    //设置上边框
    public func topBorder(width:CGFloat,borderColor:UIColor){
        let rect = CGRect(x: 0, y: 0, width: self.frame.size.width, height: width)
        drawBorder(rect: rect, color: borderColor)
    }
    
    
    //设置底边框
    public func buttomBorder(width:CGFloat,borderColor:UIColor){
        let rect = CGRect(x: 0, y: self.frame.size.height-width, width: self.frame.size.width, height: width)
        drawBorder(rect: rect, color: borderColor)
    }
}

// UIView 渐变色 , UIView及其子类都可以使用，比如UIButton、UILabel等。
// Usage:
// myButton.gradientColor(CGPoint(x: 0, y: 0.5), CGPoint(x: 1, y: 0.5), [UIColor(hex: "#FF2619").cgColor, UIColor(hex: "#FF8030").cgColor])
extension UIView {
    //Colors：渐变色色值数组
    public func setLayerColors(_ startPoint: CGPoint, _ endPoint: CGPoint,_ colors:[CGColor])  {
            let layer = CAGradientLayer()
            layer.frame = bounds
            layer.colors = colors
            layer.startPoint = startPoint
            layer.endPoint = endPoint
            self.layer.addSublayer(layer)
        }
    
    @discardableResult
    public func gradientColor(_ startPoint: CGPoint, _ endPoint: CGPoint, _ colors: [Any], _ locations: [NSNumber]? = nil) -> CAGradientLayer? {
        guard startPoint.x >= 0, startPoint.x <= 1, startPoint.y >= 0, startPoint.y <= 1, endPoint.x >= 0, endPoint.x <= 1, endPoint.y >= 0, endPoint.y <= 1 else {
            return nil
        }
        layoutIfNeeded()
        var gradientLayer: CAGradientLayer!
        removeGradientLayer()
        gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.layer.bounds
        gradientLayer.startPoint = startPoint
        gradientLayer.endPoint = endPoint
        gradientLayer.locations = locations
        gradientLayer.colors = colors
        gradientLayer.cornerRadius = self.layer.cornerRadius
        gradientLayer.masksToBounds = true
        self.layer.insertSublayer(gradientLayer, at: 0)
        self.backgroundColor = UIColor.clear
        self.layer.masksToBounds = false
        return gradientLayer
    }
    
    public func removeGradientLayer() {
        if let sl = self.layer.sublayers {
            for layer in sl {
                if layer.isKind(of: CAGradientLayer.self) {
                    layer.removeFromSuperlayer()
                }
            }
        }
    }
}

extension UIView {
    public var parentVC: UIViewController? {
        var parentResponder: UIResponder? = self
        while parentResponder != nil {
            parentResponder = parentResponder!.next
            if let viewController = parentResponder as? UIViewController {
                return viewController
            }
        }
        return nil
    }
}

extension UIView {
    public var screenShot: UIImage?  {
        UIGraphicsBeginImageContextWithOptions(bounds.size, false, 2);
        if let _ = UIGraphicsGetCurrentContext() {
            drawHierarchy(in: bounds, afterScreenUpdates: true)
            let screenshot = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            return screenshot
        }
        return nil
    }
}
