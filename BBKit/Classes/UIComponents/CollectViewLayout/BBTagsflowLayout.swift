////  BBTagsflowLayout.swift
//  _idx_main_A77C1EB9_ios_min12.2
//
//  Created by lk on 2022/8/18.
//  Copyright © 2022 Bilibili. All rights reserved.
//

import UIKit

protocol UICollectionViewCategoryLayoutDelegate: AnyObject {
    // require
    /// 返回每个item的Size
    func categoryLayout(_ categoryLayout:BBTagsflowLayout, sizeForItemAt indexPath:IndexPath) -> CGSize
    
    // optional
    func categoryLayout(_ categoryLayout:BBTagsflowLayout, columnMarginAt indexPath:IndexPath) -> CGFloat
    /// 行间距
    func categoryLayout(_ categoryLayout:BBTagsflowLayout, rowMarginAt indexPath:IndexPath) -> CGFloat
    /// 列间距
    func categoryLayout(_ categoryLayout:BBTagsflowLayout, edgInsetAt indexPath:IndexPath) -> UIEdgeInsets
    /// head的frame
    func categoryLayout(_ categoryLayout:BBTagsflowLayout, sizeForHeaderViewIn section:Int) -> CGSize
    /// foot的frame
    func categoryLayout(_ categoryLayout:BBTagsflowLayout, sizeForFooterViewIn section:Int) -> CGSize
    
}

extension UICollectionViewCategoryLayoutDelegate {
    /// 返回列间距 默认是 8
    func categoryLayout(_ categoryLayout:BBTagsflowLayout, columnMarginAt indexPath:IndexPath) -> CGFloat {
        return 8
    }
    
    /// 返回行间距 默认是8
    func categoryLayout(_ categoryLayout:BBTagsflowLayout, rowMarginAt indexPath:IndexPath) -> CGFloat{
        return 8
    }

    /// 返回每个 section 的 UIEdgeInsets
    func categoryLayout(_ categoryLayout:BBTagsflowLayout, edgInsetAt indexPath:IndexPath) -> UIEdgeInsets{
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    /// 返回透视图的size
    func categoryLayout(_ categoryLayout:BBTagsflowLayout, sizeForHeaderViewIn section:Int) -> CGSize{
        return .zero
    }
    
    /// 返回尾视图的size
    func categoryLayout(_ categoryLayout:BBTagsflowLayout, sizeForFooterViewIn section:Int) -> CGSize{
        return .zero
    }
    
    
}


/// 标签布局
class BBTagsflowLayout: UICollectionViewLayout {

    
    /// 存储最大的高度
    var maxHeight:CGFloat = 0.0
    weak var deleagte:UICollectionViewCategoryLayoutDelegate!
    /// 存放当前 Rect 中的所有 布局属性
    lazy var attriArray:[UICollectionViewLayoutAttributes] = []
    /// 记录上个cell的 最大 X 值 x + width
    var lastMaxX:CGFloat = 0.0
    
    /// 上个cell的 Y值
    var lastMaxY:CGFloat = 0.0

    override func prepare() {
        super.prepare()
        self.attriArray.removeAll()
        self.maxHeight = 0.0
        self.lastMaxX = 0.0
        self.lastMaxY = 0.0
        
        if let collectionView = self.collectionView {
            let sectionCount = collectionView.numberOfSections
            for section in 0..<sectionCount{
                
                self.lastMaxX = 0.0
                // header
                let headerAttr = self.layoutAttributesForSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, at: IndexPath.init(item: 0, section: section))
                if let headerAttr = headerAttr {
                    self.attriArray.append(headerAttr)
                }
                
                // item
                let rowCount = collectionView.numberOfItems(inSection: section)
                for item in 0..<rowCount{
                    let itemAttri = self.layoutAttributesForItem(at: IndexPath.init(item: item, section: section))
                    if let itemAttri = itemAttri{
                        self.attriArray.append(itemAttri)
                    }
                }
                
                // footer
                let footerAttri = self.layoutAttributesForSupplementaryView(ofKind:UICollectionView.elementKindSectionFooter, at: IndexPath.init(item: 0, section: section))
                if let footerAttri = footerAttri {
                   self.attriArray.append(footerAttri)
                }
            }
        }
    }
    
    override var collectionViewContentSize: CGSize{
        return CGSize(width: 0, height: self.maxHeight)
    }
    
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return self.attriArray
    }
    
    override func layoutAttributesForSupplementaryView(ofKind elementKind: String, at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        var attri:UICollectionViewLayoutAttributes!
        if elementKind == UICollectionView.elementKindSectionHeader {
            attri = UICollectionViewLayoutAttributes.init(forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, with: indexPath)
            attri.frame = self.headerViewFrame(indexPath: indexPath)
        }else{
            attri = UICollectionViewLayoutAttributes.init(forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, with: indexPath)
            attri.frame = self.footerViewFrame(indexPath: indexPath)
        }
        return attri
    }
    
    
    func headerViewFrame(indexPath:IndexPath) -> CGRect {
        let edgInset = self.deleagte.categoryLayout(self, edgInsetAt: indexPath)
        let size = self.deleagte.categoryLayout(self, sizeForHeaderViewIn: indexPath.section)
        let rwoMargin = self.deleagte.categoryLayout(self, rowMarginAt: indexPath)
        let x:CGFloat = 0.0
        let y = self.maxHeight == 0.0 ? edgInset.top : self.maxHeight
        self.maxHeight = self.maxHeight + size.height + rwoMargin
        self.lastMaxY = self.maxHeight
        return CGRect(x: x, y: y, width: size.width, height: size.height)
        
    }
    
    func footerViewFrame(indexPath:IndexPath) -> CGRect {
        let edgInset = self.deleagte.categoryLayout(self, edgInsetAt: indexPath)
        let size = self.deleagte.categoryLayout(self, sizeForFooterViewIn: indexPath.section)
        let rwoMargin = self.deleagte.categoryLayout(self, rowMarginAt: indexPath)
        let x:CGFloat = 0.0
        let y = self.maxHeight == 0.0 ? edgInset.top : self.maxHeight + rwoMargin
        self.maxHeight = self.maxHeight + size.height
        self.lastMaxY = self.maxHeight
        return CGRect(x: x, y: y, width: size.width, height: size.height)
    }
    
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        let attr = UICollectionViewLayoutAttributes.init(forCellWith: indexPath)
        let width = self.collectionView!.frame.size.width
        let edgInset = self.deleagte.categoryLayout(self, edgInsetAt: indexPath)
        let size = self.deleagte.categoryLayout(self, sizeForItemAt: indexPath)
        let columMarigin = self.deleagte.categoryLayout(self, columnMarginAt: indexPath)
        let rowMargin = self.deleagte.categoryLayout(self, rowMarginAt: indexPath)
        
        var x:CGFloat = 0.0
        if self.maxHeight == 0.0 {
            self.lastMaxY = edgInset.top
        }
        // 表示行的最开始
        if self.lastMaxX >= edgInset.left {
            x = self.lastMaxX + columMarigin
            self.lastMaxX = x + size.width
            // 换行显示了
            if x + size.width + edgInset.right > width {
                x = edgInset.left
                // 换行
                self.lastMaxX = edgInset.left + size.width
                self.lastMaxY = self.lastMaxY + size.height + rowMargin
            }
        }else{
            // 有可能存在一个 标签太长, 一整行都显示不下去
            x = edgInset.left
            self.lastMaxX = edgInset.left + size.width
        }
        
       
            
        self.maxHeight = self.lastMaxY + size.height + edgInset.bottom
        attr.frame = CGRect(x: x, y: self.lastMaxY, width: size.width, height: size.height)
        return attr
    }
}

