//
//  UIView+Frame.swift
//  BBKit
//
//  Created by lk on 2023/2/17.
//

import UIKit

public extension UIView {
    var bb_x:CGFloat{
        get{ return self.frame.origin.x.noNan }
        set{ self.frame = CGRect(x: newValue.noNan, y: self.frame.origin.y.noNan, width: self.frame.size.width.noNan, height: self.frame.size.height.noNan) }
    }
    var bb_y:CGFloat{
        get{ return self.frame.origin.y.noNan }
        set{ self.frame = CGRect(x: self.frame.origin.x.noNan, y: newValue.noNan, width: self.frame.size.width.noNan, height: self.frame.size.height.noNan) }
    }
    
    var bb_width:CGFloat{
        get{ return self.frame.size.width.noNan }
        set{ self.frame = CGRect(x: self.frame.origin.x.noNan, y: self.frame.origin.y.noNan, width: newValue.noNan, height: self.frame.size.height.noNan) }
    }
    
    var bb_height:CGFloat{
        get{ return self.frame.size.height.noNan }
        set{ self.frame = CGRect(x: self.frame.origin.x.noNan, y: self.frame.origin.y.noNan, width: self.frame.size.width.noNan, height: newValue.noNan) }
    }
    var bb_left: CGFloat {
        get {return self.bb_x.noNan }
        set {
            var frame = self.frame
            frame.origin.x = newValue.noNan;
            self.frame = frame
        }
    }
    var bb_right: CGFloat {
        get {return self.bb_x + self.bb_width }
        set {
            var frame = self.frame
            frame.origin.x = newValue.noNan - self.bb_width;
            self.frame = frame
        }
    }
    var bb_top: CGFloat {
        get { return self.bb_y }
        set {
            var frame = self.frame
            frame.origin.y = newValue.noNan
            self.frame = frame
        }
    }
    var bb_bottom: CGFloat {
        get { return self.bb_y + self.bb_height }
        set {
            var frame = self.frame
            frame.origin.y = newValue.noNan - self.bb_height;
            self.frame = frame
        }
    }
    
    // size
    var bb_size: CGSize {
        get { return self.frame.size }
        set { self.frame = CGRect(x: self.frame.origin.x.noNan, y: self.frame.origin.y.noNan, width: newValue.width.noNan, height: newValue.height.noNan) }
    }
    // origin
    var bb_origin: CGPoint {
        get { return self.frame.origin }
        set { self.frame.origin = newValue }
    }
    
    var bb_centerX: CGFloat {
        get { return self.center.x.noNan }
        set {
            var frame = self.frame
            frame.origin.x = newValue.noNan - frame.size.width.noNan * 0.5
            self.frame = frame;
        }
    }
    var bb_centerY: CGFloat {
        get { return self.center.y.noNan }
        set {
            var frame = self.frame
            frame.origin.y = newValue.noNan - frame.size.height.noNan * 0.5
            self.frame = frame;
        }
    }
}
