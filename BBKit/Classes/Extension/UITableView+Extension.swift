//
//  UITableView+Extension.swift
//  BBKit
//
//  Created by 肥啊 on 2023/2/18.
//

import UIKit

public extension UITableView {
    func defaultCell() -> UITableViewCell {
        var cell:UITableViewCell? = self.dequeueReusableCell(withIdentifier: UITableViewCell.identifier)
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: UITableViewCell.identifier)
        }
        return cell!
    }
    
    func reloadRows(_ section: Int = 0, row: Int, with animation: RowAnimation) {
        let indexPath = IndexPath(row: row, section: section)
        
        if section < self.numberOfSections, row < self.numberOfRows(inSection: section) {
            self.reloadRows(at: [indexPath], with: animation)
        } else {
            print("reloadRows越界")
        }
    }
    
    func reloadSections(_ section: Int, with animation: RowAnimation) {
        if section < self.numberOfSections {
            self.reloadSections([section], with: animation)
        } else {
            print("reloadSections越界")
        }
    }
    
    func deleteRows(_ section:Int = 0, row: Int, with animation: RowAnimation) {
        let indexPath = IndexPath(row: row, section: section)
        if section < self.numberOfSections, row < self.numberOfRows(inSection: section) {
            self.deleteRows(at: [indexPath], with: animation)
        } else {
            print("deleteRows越界")
        }
    }

    func cellForRow(_ section: Int = 0, row: Int) -> UITableViewCell? {
        let indexPath = IndexPath(row: row, section: section)
        return self.cellForRow(at: indexPath)
        
    }
    
    func scrollToRow(_ section: Int = 0, row: Int, at scrollPosition: UITableView.ScrollPosition, animated: Bool) {
        if section < self.numberOfSections, row < self.numberOfRows(inSection: section) {
            let indexPath = IndexPath(row: row, section: section)
            self.scrollToRow(at: indexPath, at: scrollPosition, animated: animated)
        } else {
            print("scrollToRow 越界")
        }
    }
    
    class func getTableView(frame: CGRect, style: UITableView.Style, target: Any) -> UITableView {
        let tableView = UITableView.init(frame: frame, style: style)
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        tableView.dataSource = target as? any UITableViewDataSource
        tableView.delegate = target as? any UITableViewDelegate
        tableView.backgroundColor = dominantColor
        tableView.estimatedRowHeight = 110
        tableView.estimatedSectionFooterHeight = 0.0
        tableView.estimatedSectionHeaderHeight = 0.0
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]

        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = 0
        }
        return tableView
    }
}
