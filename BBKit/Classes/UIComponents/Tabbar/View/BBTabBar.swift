//
//  BBTabBar.swift
//  BBKit
//
//  Created by lk on 2023/2/22.
//

import UIKit
import Foundation

protocol BBTabbarDelegate: AnyObject {
    func tabBar(_ tabBar: BBTabBar, didSelect item: BBTabbarItem, index: Int)
}

open class BBTabBar: UITabBar {
    
    private var tabbarItems: [BBTabbarItem] = []
    public var dataItems:[BBItemModel] = [] {
        didSet {
            self.tabbarItems.removeAll()
            setupUI()
        }
    }
    
    weak var b_delegate: BBTabbarDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = dominantColor
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        self.removeAllSubviews()
        
        let width = self.bb_width / CGFloat(dataItems.count)
        for (index,item) in dataItems.enumerated() {
            let itemView = BBTabbarItem(frame: CGRect(x: CGFloat(index) * width, y: 0, width: width, height: KTabBarheight))
            itemView.setupData(data: item)
            itemView.tag = 10 + index
            let tap = UITapGestureRecognizer(target: self, action: #selector(clickItemView(sender:)))
            itemView.addGestureRecognizer(tap)
            self.addSubview(itemView)
            self.tabbarItems.append(itemView)
        }
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        
        for tempView in self.subviews {
            if (tempView.isKind(of: NSClassFromString("UITabBarButton")!)) {
                tempView.removeFromSuperview()
            }
        }
    }
    
    @objc func clickItemView(sender: UITapGestureRecognizer) {
        if let view = sender.view as? BBTabbarItem {
            let tag = view.tag - 10
            self.b_delegate?.tabBar(self, didSelect: view, index: tag)
        }
    }
    
    public func selectedItem(_ index: Int) {
        for (i, tabbarItem) in self.tabbarItems.enumerated() {
            if index == i {
                tabbarItem.selected()
            } else {
                tabbarItem.reset()
            }
        }
    }
}
