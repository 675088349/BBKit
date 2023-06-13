////  PGFlowLayout.swift
//  _idx_main_A77C1EB9_ios_min12.2
//
//  Created by lk on 2022/8/17.
//  Copyright © 2022 Bilibili. All rights reserved.
//

import UIKit

protocol BBHorizontalWaterflowLayoutDelegate : AnyObject {
    /// 返回item的宽度
    func waterflowLayout(waterflowLayout: PGHorizontalWaterflowLayout, index:Int, itemHeight:CGFloat) -> CGFloat
    /// 共几行 默认2行
    func rowCountInWaterflowLayout(waterflowLayout: PGHorizontalWaterflowLayout) -> Int
    /// 每一列之间的距离
    func columnMarginInWaterflowLayout(waterflowLayout: PGHorizontalWaterflowLayout) -> CGFloat
    /// 每一行之间的距离
    func rowMarginInWaterflowLayout(waterflowLayout: PGHorizontalWaterflowLayout) -> CGFloat
    /// 内边距
    func edgeInsetsInWaterflowLayout(waterflowLayout: PGHorizontalWaterflowLayout) -> UIEdgeInsets
}

extension BBHorizontalWaterflowLayoutDelegate {
    
    func rowCountInWaterflowLayout(waterflowLayout: PGHorizontalWaterflowLayout) -> Int {
        return 2
    }
    
    /// 每一列之间的距离
    func columnMarginInWaterflowLayout(waterflowLayout: PGHorizontalWaterflowLayout) -> CGFloat {
        return 8
    }
    /// 每一行之间的距离
    func rowMarginInWaterflowLayout(waterflowLayout: PGHorizontalWaterflowLayout) -> CGFloat {
        return 8
    }
    /// 内边距
    func edgeInsetsInWaterflowLayout(waterflowLayout: PGHorizontalWaterflowLayout) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
}

/// 横向瀑布流 目前仅支持横向
class PGHorizontalWaterflowLayout: UICollectionViewFlowLayout {

    weak var delegate: BBHorizontalWaterflowLayoutDelegate!
    
    // 存放所有cell的布局
    lazy var attrsArray:[UICollectionViewLayoutAttributes] = []
    // 存放所有列的当前宽度
    lazy var rowWidths:[CGFloat] = []
    // 内容宽度
    var contentWidth:CGFloat = 0
    
    var rowMargin:CGFloat {
        return self.delegate.rowMarginInWaterflowLayout(waterflowLayout: self)
    }
    
    var columnMargin:CGFloat {
        self.delegate.columnMarginInWaterflowLayout(waterflowLayout: self)
    }
    
    var edgeInsets: UIEdgeInsets {
        self.delegate.edgeInsetsInWaterflowLayout(waterflowLayout: self)
    }
    
    var rowCount:Int {
        self.delegate.rowCountInWaterflowLayout(waterflowLayout: self)
    }
    
    override func prepare() {
        super.prepare()
        
        self.contentWidth = 0
        self.rowWidths.removeAll()
        
        for _ in 0..<self.rowCount {
            self.rowWidths.append(self.edgeInsets.left)
        }
        
        self.attrsArray.removeAll()
        let count:Int = self.collectionView?.numberOfItems(inSection: 0) ?? 0
    
        for i in 0..<count {
            let indexPath = IndexPath.init(item: i, section: 0)
            let attrs = self.layoutAttributesForItem(at: indexPath) ?? UICollectionViewLayoutAttributes()
            self.attrsArray.append(attrs)
        }
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return self.attrsArray
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        let attrs = UICollectionViewLayoutAttributes(forCellWith: indexPath)
        let collectionViewH:CGFloat = self.collectionView?.bb_size.height ?? 0
        
        let h = (collectionViewH - self.edgeInsets.top - self.edgeInsets.bottom - CGFloat(self.rowCount - 1) * self.rowMargin) / CGFloat(self.rowCount)
        let w:CGFloat = self.delegate.waterflowLayout(waterflowLayout: self, index: indexPath.item, itemHeight: h)
        
        var destRow = 0
        var minRowWidth:CGFloat = self.rowWidths.getValue(at: 0) ?? 0
        
        for i in 1..<self.rowCount {
            let rowWidth:CGFloat = self.rowWidths.getValue(at: i) ?? 0
            if minRowWidth > rowWidth {
                minRowWidth = rowWidth
                destRow = i
            }
        }
        
        let y = self.edgeInsets.top + CGFloat(destRow) * (h + self.rowMargin)
        var x = minRowWidth
        if x != self.edgeInsets.left {
            x += self.columnMargin
        }
        
        attrs.frame = CGRect(x: x, y: y, width: w, height: h)

        self.rowWidths[destRow] = attrs.frame.maxX
        
        let rowWidth = self.rowWidths[destRow]
        if self.contentWidth < rowWidth {
            self.contentWidth = rowWidth
        }
        
        return attrs;
    }
    
    override var collectionViewContentSize: CGSize {
        return CGSize(width: self.contentWidth + self.edgeInsets.right + self.edgeInsets.left, height: (self.collectionView?.frame.size.height ?? 0))
    }

}

