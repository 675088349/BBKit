//
//  UICollectionViewCell+Extension.swift
//  BBKit
//
//  Created by 肥啊 on 2023/2/18.
//

import UIKit

extension UICollectionViewCell {
    
    // 标识符
    static public var identifier: String {
        get {
            let classStr = NSStringFromClass(self)
            // 获取类名
            return classStr.components(separatedBy: ".").last!
        }
    }
    
    public var indexPath: IndexPath? {
        if let collectionView = self._collectionView {
            if let cell = self.findTheTureCell(with: self.contentView) {
                if let indexPath = collectionView.indexPath(for: cell) {
                    return indexPath
                }
            }
        }
        return nil
    }
    
    public var _collectionView:UICollectionView? {
        var responder: UIResponder? = self.next
        while (responder != nil) {
            if let tableView = responder as? UICollectionView {
                return tableView
            }
            responder = responder?.next
        }
        
        return nil
    }
    
    /**
     *  cell 点击调用该方法，将会回调给 UICollectionView 的 delegate 里面，执行：collectionView:clickCell:atView: 方法
     *  @param  view    被点击的视图
     */
    public func cellClick(at view:UIView) {
        if let collectionView = self._collectionView {
            if let delegate = collectionView.delegate as? NSObject {
                if let cell = self.findTheTureCell(with: view) {
                    if let indexPath = collectionView.indexPath(for: cell) {
                        delegate.collectionView(collectionView: collectionView, clickCell: cell, atView: view, indexPath: indexPath)
                    }
                }
            }
        }
    }
    
    /**
     cell 调用该方法，将会回调给 collectionView 的 delegate 里面，执行 collectionView:sendDataCell:sendData:indexPath: 方法
     
     @param data 发送的数据
     */
    public func cellSendData(data: Any?) {
        if let collectionView = self._collectionView {
            if let delegate = collectionView.delegate as? NSObject {
                if let cell = self.findTheTureCell(with: self.contentView) {
                    if let indexPath = collectionView.indexPath(for: cell) {
                        delegate.collectionView(collectionView: collectionView, sendDataCell: cell, data: data, indexPath: indexPath)
                    }
                }
            }
        }
    }
    
    public func findTheTureCell(with view:UIView) -> UICollectionViewCell? {
        var responder: UIResponder? = view.next
        while (responder != nil) {
            if let cell = responder as? UICollectionViewCell {
                return cell
            }
            responder = responder?.next
        }
        return nil
    }
}
