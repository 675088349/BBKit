//
//  NSObject+Extension.swift
//  BBKit
//
//  Created by 肥啊 on 2023/2/18.
//

import UIKit

extension NSObject {
    
    /**
     *  cell 中调用 cellClickAtView: 方法，最终会触发 tableView 的 delegate 中执行该方法
     *  @param  tableView   cell 所在 tableView
     *  @param  clickCell   哪个 cell 中触发了点击事件
     *  @param  view        点击的是 cell 中哪个视图
     *  @param  indexPath   cell 所在 indexPath
     */
    @objc open func tableView(tableView:UITableView, clickCell:UITableViewCell, atView:UIView, indexPath:IndexPath) {}
    
    /**
     cell 中调用 cellSendData: 方法 最终会触发 tableView 的 delegate 中执行该方法
     
     @param tableView cell 所在 tableView
     @param sendDataCell 哪个 cell 中发送了数据
     @param data 发送的数据
     @param indexPath cell 所在 indexPath
     */
    @objc open func tableView(tableView:UITableView, sendDataCell:UITableViewCell, data:Any?, indexPath:IndexPath) {}
    
    /**
     *  cell 中调用 cellClickAtView: 方法，最终会触发 collectionView 的 delegate 中执行该方法
     *  @param  collectionView   cell 所在 collectionView
     *  @param  clickCell   哪个 cell 中触发了点击事件
     *  @param  view        点击的是 cell 中哪个视图
     *  @param  indexPath   cell 所在 indexPath
     */
    @objc open func collectionView(collectionView:UICollectionView, clickCell:UICollectionViewCell, atView:UIView, indexPath:IndexPath) {}
    
    /**
     cell 中调用 cellSendData: 方法 最终会触发 collectionView 的 delegate 中执行该方法
     
     @param collectionView cell 所在 collectionView
     @param sendDataCell 哪个 cell 中发送了数据
     @param data 发送的数据
     @param indexPath cell 所在 indexPath
     */
    @objc open func collectionView(collectionView:UICollectionView, sendDataCell:UICollectionViewCell, data:Any?, indexPath:IndexPath) {}
}
