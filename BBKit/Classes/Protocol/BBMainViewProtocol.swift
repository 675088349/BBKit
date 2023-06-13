//
//  BBMainViewProtocol.swift
//  BBKit
//
//  Created by lk on 2023/3/2.
//

import UIKit

@objc public protocol BBMainViewProtocol {
    @objc optional func viewDidLoad()
    @objc optional func baseLoadData()
    @objc optional func viewWillAppear(_ animated: Bool)
}


