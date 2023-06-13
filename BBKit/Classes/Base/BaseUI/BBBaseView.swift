//
//  BBBaseView.swift
//  BBKit
//
//  Created by 肥啊 on 2023/2/18.
//

import UIKit

open class BBBaseView: UIView {
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setupUI()
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open func setupUI() {
        self.backgroundColor = dominantColor
    }
    
    open func setupData(data: Any?) {
        
    }
}
