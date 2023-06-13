//
//  UIScrollView+MJRefresh.swift
//  BBKit
//
//  Created by 肥啊 on 2023/3/19.
//

import UIKit
//import MJRefresh
//
//public extension UIScrollView {
//    
//    func addRefreshHeader(begin header: @escaping BBGlobalBlock) {
//        let header = MJRefreshNormalHeader {
//            header()
//        }
//        self.mj_header = header
//    }
//    
//    func addRefreshFooter(begin footer: @escaping BBGlobalBlock) {
//        let footer = MJRefreshAutoStateFooter {
//            footer()
//        }
//        footer.setTitle("我也是有底线的(￣３￣)^", for: .noMoreData)
//        self.mj_footer = footer
//    }
//    
//    func endRefresh(noMore: Bool = false) {
//        if let header = self.mj_header, header.isRefreshing {
//            self.mj_header?.endRefreshing()
//            
//            if !noMore {
//                if self.mj_footer?.isHidden == true {
//                    self.mj_footer?.isHidden = false
//                }
//                if self.mj_footer?.state == .noMoreData {
//                    self.mj_footer?.resetNoMoreData()
//                }
//            } else {
//                self.mj_footer?.isHidden = false
//                self.mj_footer?.endRefreshingWithNoMoreData()
//            }
//        } else if let footer = self.mj_footer, footer.isRefreshing {
//            self.mj_footer?.isHidden = false
//            if !noMore {
//                self.mj_footer?.endRefreshing()
//            } else {
//                self.mj_footer?.endRefreshingWithNoMoreData()
//            }
//        }
//    }
//}
