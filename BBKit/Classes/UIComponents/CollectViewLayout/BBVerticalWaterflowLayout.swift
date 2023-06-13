////  BBVerticalWaterflowLayout.swift
//  pogo
//
//  Created by xukun on 2022/10/10.
//  Copyright © 2022 Bilibili. All rights reserved.
//

import UIKit

extension UICollectionViewLayoutAttributes {

    /** 每行第一个item左对齐 **/
    func leftAlignFrame(sectionInset:UIEdgeInsets) {
        var frame = self.frame
        frame.origin.x = sectionInset.left
        self.frame = frame
    }
}

class BBVerticalWaterflowLayout: UICollectionViewFlowLayout {

    //MARK: - 重新UICollectionViewFlowLayout的方法

    /** Collection所有的UICollectionViewLayoutAttributes */
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let attributesToReturn = super.layoutAttributesForElements(in: rect)!
        for attributes in attributesToReturn {
            if nil == attributes.representedElementKind {
                let indexPath = attributes.indexPath
                attributes.frame = self.layoutAttributesForItem(at: indexPath)!.frame
            }
        }
        return attributesToReturn
    }

    /** 每个item的UICollectionViewLayoutAttributes */
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        //现在item的UICollectionViewLayoutAttributes
        let currentItemAttributes = super.layoutAttributesForItem(at: indexPath)!
        //现在section的sectionInset
        let sectionInset = self.evaluatedSectionInset(itemAtIndex: indexPath.section)
        //是否是section的第一个item
        let isFirstItemInSection = indexPath.item == 0
        //出去section偏移量的宽度
        let width = self.collectionView?.frame.width ?? 0
        let layoutWidth: CGFloat = width - sectionInset.left - sectionInset.right
        //是section的第一个item
        if isFirstItemInSection {
            //每行第一个item左对齐
            currentItemAttributes.leftAlignFrame(sectionInset: sectionInset)
            return currentItemAttributes
        }
    
        //前一个item的NSIndexPath
        let previousIndexPath = NSIndexPath(item: indexPath.item - 1, section: indexPath.section)
        //前一个item的frame
        let previousFrame = self.layoutAttributesForItem(at: previousIndexPath as IndexPath)!.frame
        //为现在item计算新的left
        let previousFrameRightPoint: CGFloat = previousFrame.origin.x + previousFrame.size.width
        //现在item的frame
        let currentFrame = currentItemAttributes.frame
        //现在item所在一行的frame
        let strecthedCurrentFrame = CGRect(x: sectionInset.left, y: currentFrame.origin.y, width: layoutWidth, height: currentFrame.size.height)
    
        //previousFrame和strecthedCurrentFrame是否有交集，没有，说明这个item和前一个item在同一行，item是这行的第一个item
        let isFirstItemInRow = !previousFrame.intersects(strecthedCurrentFrame)
//        !CGRectIntersectsRect(previousFrame, strecthedCurrentFrame)
        //item是这行的第一个item
        if isFirstItemInRow {
            //每行第一个item左对齐
            currentItemAttributes.leftAlignFrame(sectionInset: sectionInset)
            return currentItemAttributes
        }
        //不是每行的第一个item
        var frame = currentItemAttributes.frame
        //为item计算新的left = previousFrameRightPoint + item之间的间距
        frame.origin.x = previousFrameRightPoint + self.evaluatedMinimumInteritemSpacing(ItemAtIndex: indexPath.item)
        //为item的frame赋新值
        currentItemAttributes.frame = frame
        return currentItemAttributes
    }

    //MARK: - System

    /** item行间距 **/
    private func evaluatedMinimumInteritemSpacing(ItemAtIndex:Int) -> CGFloat     {
        if let delete = self.collectionView?.delegate {
            weak var delegate = (delete as! UICollectionViewDelegateFlowLayout)
            if ((delegate?.responds(to: #selector(UICollectionViewDelegateFlowLayout.collectionView(_:layout:minimumLineSpacingForSectionAt:)))) != nil){
                let mini = delegate?.collectionView?(self.collectionView!, layout: self, minimumInteritemSpacingForSectionAt: ItemAtIndex)
                if mini != nil {
                    return mini!
                }
            }
        }
        return self.minimumInteritemSpacing
    }
    
    /** section的偏移量 **/
    private func evaluatedSectionInset(itemAtIndex:Int) -> UIEdgeInsets {
        if let delete = self.collectionView?.delegate {
            weak var delegate = (delete as! UICollectionViewDelegateFlowLayout)
            if ((delegate?.responds(to: #selector(UICollectionViewDelegateFlowLayout.collectionView(_:layout:minimumLineSpacingForSectionAt:)))) != nil){
                let sectionInset =  delegate?.collectionView?(self.collectionView!, layout: self, insetForSectionAt: itemAtIndex)
                if sectionInset != nil {
                    return sectionInset!
                }
            }
        }
        return self.sectionInset
    }
}
