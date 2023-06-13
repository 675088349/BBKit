//
//  BBTabbar.swift
//  BBKit
//
//  Created by lk on 2023/2/22.
//

import UIKit

open class BBTabBarController: UITabBarController {
    
    lazy var tabbar: BBTabBar = {
        let view = BBTabBar(frame: CGRect(x: 0, y: 0, width: KScreenWidth, height: KTabBarheight))
        view.b_delegate = self
        return view
    }()
    
    public var items: [BBItemModel] = [] {
        didSet {
            tabbar.dataItems = items
        }
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupUI()
    }
    
    public func setupUI() {
        self.setValue(tabbar, forKey: "tabBar")
    }

    public func setSelectedIndex(_ index: Int) {
        self.selectedIndex = index
        tabbar.selectedItem(index)
    }
}

extension BBTabBarController: BBTabbarDelegate {
    func tabBar(_ tabBar: BBTabBar, didSelect item: BBTabbarItem, index: Int) {
        self.selectedIndex = index
        tabBar.selectedItem(index)
    }
}
