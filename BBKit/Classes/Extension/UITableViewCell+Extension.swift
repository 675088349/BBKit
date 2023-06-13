//
//  UITableViewCell+Extension.swift
//  BBKit
//
//  Created by 肥啊 on 2023/2/18.
//

import UIKit

extension UITableViewCell {
    
    public var tableView:UITableView? {
        var responder: UIResponder? = self.next
        while (responder != nil) {
            if let tableView = responder as? UITableView {
                return tableView
            }
            responder = responder?.next
        }
        
        return nil
    }
    
    // 标识符
    static public var identifier: String {
        get {
            let classStr = NSStringFromClass(self)
            // 获取类名
            return classStr.components(separatedBy: ".").last!
        }
    }
    
    public var indexPath: IndexPath? {
        if let tableView = self.tableView {
            if let cell = self.findTheTureCell(with: self.contentView) {
                if let indexPath = tableView.indexPath(for: cell) {
                    return indexPath
                }
            }
        }
        return nil
    }
    
    /**
     *  cell 点击调用该方法，将会回调给 tableView 的 delegate 里面，执行：tableView:clickCell:atView: 方法
     *  @param  view    被点击的视图
     */
    public func cellClick(at view:UIView) {
        if let tableView = self.tableView {
            if let delegate = tableView.delegate as? NSObject {
                if let cell = self.findTheTureCell(with: view) {
                    if let indexPath = tableView.indexPath(for: cell) {
                        delegate.tableView(tableView: tableView, clickCell: cell, atView: view, indexPath: indexPath)
                    }
                }
            }
        }
    }
    
    /**
     cell 调用该方法，将会回调给 tableview 的 delegate 里面，执行 tableView:sendDataCell:sendData:indexPath: 方法
     
     @param data 发送的数据
     */
    public func cellSendData(data: Any?) {
        if let tableView = self.tableView {
            if let delegate = tableView.delegate as? NSObject {
                if let cell = self.findTheTureCell(with: self.contentView) {
                    if let indexPath = tableView.indexPath(for: cell) {
                        delegate.tableView(tableView: tableView, sendDataCell: cell, data: data, indexPath: indexPath)
                    }
                }
            }
        }
    }
    
    public func findTheTureCell(with view:UIView) -> UITableViewCell? {
        var responder: UIResponder? = view.next
        while (responder != nil) {
            if let cell = responder as? UITableViewCell {
                return cell
            }
            responder = responder?.next
        }
        return nil
    }
}
