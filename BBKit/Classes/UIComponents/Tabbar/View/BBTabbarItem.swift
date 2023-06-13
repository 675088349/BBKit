//
//  BBTabbarItem.swift
//  BBKit
//
//  Created by lk on 2023/2/22.
//

import UIKit

public struct BBItemModel {
    public init() {
        
    }
    public var image: UIImage?
    public var title: String?
    public var textColor: UIColor = .black
    public var font: UIFont = .font(size: 12)

    public var selectedImage: UIImage?
    public var selectedTitle: String?
    public var selectedTextColor: UIColor = .black
    public var selectedFont: UIFont = .boldFont(size: 12)
}


open class BBTabbarItem: BBBaseView {
    lazy var imageView: UIImageView = {
        let imageV = UIImageView.getImageView()
        return imageV
    }()
    
    lazy var titleLabel: UILabel = {
        return UILabel.getLabel(font: .font(size: 12), textColor: .black, textAlignment: .center)
    }()
    
    var itemModel: BBItemModel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.isUserInteractionEnabled = true
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open override func setupUI() {
        self.backgroundColor = dominantColor
        self.addSubview(imageView)
        self.addSubview(titleLabel)
        
        imageView.frame = CGRect(x: 0, y: 5, width: 24, height: 24)
        titleLabel.frame = CGRect(x: 0, y: 0, width: self.bb_width, height: self.bb_height - imageView.bb_bottom)
        
        imageView.bb_centerX = self.bb_width/2
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        
        titleLabel.sizeToFit()
        titleLabel.bb_top = imageView.bb_bottom + 7
        titleLabel.bb_centerX = self.bb_width/2
    }
    
    func reset() {
        self.titleLabel.text = itemModel?.title
        self.imageView.image = itemModel?.image
        self.titleLabel.font = itemModel?.font
        self.titleLabel.textColor = itemModel?.textColor
    }
    
    func selected() {
        self.titleLabel.text = itemModel?.selectedTitle ?? itemModel?.title
        self.imageView.image = itemModel?.selectedImage ?? itemModel?.image
        self.titleLabel.font = itemModel?.selectedFont ?? itemModel?.font
        self.titleLabel.textColor = itemModel?.selectedTextColor ?? itemModel?.textColor
    }
    
    open override func setupData(data: Any?) {
        self.itemModel = data as? BBItemModel
        self.reset()
    }
}
