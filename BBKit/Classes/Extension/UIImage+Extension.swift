//
//  UIImage+Extension.swift
//  BBKit
//
//  Created by 肥啊 on 2023/2/18.
//

import Foundation
import UIKit

public extension UIImage {
    /**
     *  重设图片大小
     */
    func reSizeImage(reSize:CGSize)->UIImage {
        //UIGraphicsBeginImageContext(reSize);
        UIGraphicsBeginImageContextWithOptions(reSize,false,UIScreen.main.scale);
        self.draw(in: CGRect(x: 0, y: 0, width: reSize.width, height: reSize.height));
        let reSizeImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!;
        UIGraphicsEndImageContext();
        return reSizeImage;
    }
    
    
   /**
    *  等比率缩放
    */
    func scaleImage(scaleSize:CGFloat)->UIImage {
       let reSize = CGSize(width: self.size.width * scaleSize, height:  self.size.height * scaleSize)
       return reSizeImage(reSize: reSize)
   }
   
   /**
    *  color to image
    */
    static func from(color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context!.setFillColor(color.cgColor)
        context!.fill(rect)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        if let ima = img {
            return ima
        }
        return UIImage.init()
   }
}
