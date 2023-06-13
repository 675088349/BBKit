//
//  CommonDefine.swift
//  BBKit
//
//  Created by 肥啊 on 2023/2/18.
//

import UIKit

public let KScreenWidth = UIScreen.main.bounds.width
public let KScreenHeight = UIScreen.main.bounds.height

public let isIPhoneX = (UIDevice().isIphoneX() ? true : false)

public let KNavBarHeight = 44.0

public let KHasFaceId: Bool = isIPhoneX

public let KBottomHeight = UIApplication.shared.windows.first?.safeAreaInsets.bottom ?? 0

public let KStatusHeight = Double(UIApplication.shared.statusBarFrame.size.height)

public let KNavBarAndStatusBarHeight = KStatusHeight+KNavBarHeight

public let KTabBarheight = 49.0+KBottomHeight


private struct LayoutHelp {
    static var screenWidth: Float = 0
}

/// 根据 设计图的尺寸 转换本机适合的像素大小
public func layoutPixel(pixel: Float) -> Float {
    DispatchQueue.once(token: "layoutHelp", block: {
        LayoutHelp.screenWidth = Float(KScreenWidth)
    })
    let convertPixel = Float(LayoutHelp.screenWidth / 375) * pixel

    return round(convertPixel)
}

public func layoutCGPixel(pixel: CGFloat) -> CGFloat {
    return CGFloat(layoutPixel(pixel: Float(pixel)))
}

/// 主色调
public let dominantColor = UIColor(hex: "F8F8F8")

public typealias BBGlobalBlock = ()->()
