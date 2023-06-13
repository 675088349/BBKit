//
//  CGFloat+Extension.swift
//  BBKit
//
//  Created by lk on 2023/3/2.
//

import Foundation

extension CGFloat {
    
    var noNan: CGFloat {
        return self.isNaN ? 0 : self
    }
    
}
