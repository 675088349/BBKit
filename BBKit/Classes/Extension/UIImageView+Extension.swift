//
//  UIImageView+Extension.swift
//  BBKit
//
//  Created by 肥啊 on 2023/2/18.
//

import UIKit

public extension UIImageView {
    
    /// 快速创建一个imageview
    static func getImageView(frame:CGRect = .zero, image: UIImage? = nil, contentMode:ContentMode = .scaleAspectFill, enabled: Bool = false, clipsToBounds: Bool = false) -> UIImageView {
        let imageView = UIImageView(frame: frame)
        imageView.contentMode = contentMode
        imageView.isUserInteractionEnabled = enabled
        imageView.clipsToBounds = clipsToBounds
        imageView.image = image
        
        return imageView
    }
    
}
 
