//
//  UIDevice+Extension.swift
//  BBKit
//
//  Created by 肥啊 on 2023/2/18.
//

import Foundation
import UIKit

public extension UIDevice {
    
    func isIphoneX() -> Bool {
        if #available(iOS 11.0, *) {
            if let window = UIApplication.shared.windows.first {
                return window.safeAreaInsets.bottom > 0
            }
        }
        return false
    }
    // MARK: - 当前设备的系统版本
    /// 当前设备的系统版本
    static var currentSystemVersion : String {
        get {
            return self.current.systemVersion
        }
    }
    
    
    // MARK: - 设备名获取
    
    var modelName: String {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        
        switch identifier {
        case "iPod1,1":  return "iPod Touch 1"
        case "iPod2,1":  return "iPod Touch 2"
        case "iPod3,1":  return "iPod Touch 3"
        case "iPod4,1":  return "iPod Touch 4"
        case "iPod5,1":  return "iPod Touch 5"
        case "iPod7,1":  return "iPod Touch 6"
        case "iPod9,1":  return "iPod Touch 7"
            
        case "iPhone3,1", "iPhone3,2", "iPhone3,3":  return "iPhone 4"
        case "iPhone4,1":  return "iPhone 4s"
        case "iPhone5,1":  return "iPhone 5"
        case "iPhone5,2":  return "iPhone 5"
        case "iPhone5,3", "iPhone5,4":  return "iPhone 5c"
        case "iPhone6,1", "iPhone6,2":  return "iPhone 5s"
        case "iPhone7,2":  return "iPhone 6"
        case "iPhone7,1":  return "iPhone 6 Plus"
        case "iPhone8,1":  return "iPhone 6s"
        case "iPhone8,2":  return "iPhone 6s Plus"
        case "iPhone8,4":  return "iPhone SE"
        case "iPhone9,1", "iPhone9,3":  return "iPhone 7"
        case "iPhone9,2", "iPhone9,4":  return "iPhone 7 Plus"
        case "iPhone10,1", "iPhone10,4": return "iPhone 8"
        case "iPhone10,2", "iPhone10,5": return "iPhone 8 Plus"
        case "iPhone10,3", "iPhone10,6": return "iPhone X"
        case "iPhone11,2": return "iPhone XS"
        case "iPhone11,4", "iPhone11,6": return "iPhone XS Max"
        case "iPhone11,8": return "iPhone XR"
        case "iPhone12,1": return "iPhone 11"
        case "iPhone12,3": return "iPhone 11 Pro"
        case "iPhone12,5": return "iPhone 11 Pro Max"
        case "iPhone12,8": return "iPhone SE 2"
        case "iPhone13,1": return "iPhone 12 mini"
        case "iPhone13,2": return "iPhone 12"
        case "iPhone13,3": return "iPhone 12 Pro"
        case "iPhone13,4": return "iPhone 12 Pro Max"
        case "iPhone14,4": return "iPhone 13 mini"
        case "iPhone14,5": return "iPhone 13"
        case "iPhone14,2": return "iPhone 13 Pro"
        case "iPhone14,3": return "iPhone 13 Pro Max"
            

            
        case "iPad1,1": return "iPad"
        case "iPad1,2": return "iPad 3G"
        case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4":  return "iPad 2"
        case "iPad2,5", "iPad2,6", "iPad2,7":  return "iPad Mini"
        case "iPad3,1", "iPad3,2", "iPad3,3":  return "iPad 3"
        case "iPad3,4", "iPad3,5", "iPad3,6":  return "iPad 4"
        case "iPad4,1", "iPad4,2", "iPad4,3":  return "iPad Air"
        case "iPad4,4", "iPad4,5", "iPad4,6":  return "iPad Mini 2"
        case "iPad4,7", "iPad4,8", "iPad4,9":  return "iPad Mini 3"
        case "iPad5,1", "iPad5,2":  return "iPad Mini 4"
        case "iPad5,3", "iPad5,4":  return "iPad Air 2"
        case "iPad6,3", "iPad6,4":  return "iPad Pro (9.7-inch)"
        case "iPad6,7", "iPad6,8":  return "iPad Pro (12.9-inch)"
        case "iPad6,11", "iPad6,12":  return "iPad 5"
        case "iPad7,1", "iPad7,2":  return "iPad Pro (12.9-inch) 2"
        case "iPad7,3", "iPad7,4":  return "iPad Pro (10.5-inch)"
        case "iPad7,5", "iPad7,6":  return "iPad 6"
        case "iPad7,11", "iPad7,12":  return "iPad 7"
        case "iPad8,1", "iPad8,2", "iPad8,3", "iPad8,4":return "iPad Pro (11-inch)"
        case "iPad8,5", "iPad8,6", "iPad8,7", "iPad8,8":return "iPad Pro (12.9-inch) 3"
        case "iPad8,9", "iPad8,10":  return "iPad Pro (11-inch) 2"
        case "iPad8,11", "iPad8,12":  return "iPad Pro (12.9-inch) 4"
        case "iPad11,1", "iPad11,2":  return "iPad mini 5"
        case "iPad11,3", "iPad11,4":  return "iPad Air 3"
        case "iPad11,6", "iPad11,7":  return "iPad 8"
        case "iPad12,1", "iPad12,2":  return "iPad 9"
        case "iPad13,1", "iPad13,2":  return "iPad Air 4"
        case "iPad13,4", "iPad13,5","iPad13,6", "iPad13,7":  return "iPad Pro (11-inch) 3"
        case "iPad13,8", "iPad13,9","iPad13,10", "iPad13,11":  return "iPad Pro (12.9-inch) 5"
        case "iPad14,1", "iPad14,2":  return "iPad Mini 6"
       
            
        case "AppleTV2,1":  return "Apple TV 2"
        case "AppleTV3,1","AppleTV3,2":  return "Apple TV 3"
        case "AppleTV5,3":  return "Apple TV 4"
        case "AppleTV6,2": return "Apple TV 4K"
        case "i386", "x86_64":  return "Simulator"
            
        default:  return identifier
        }
    }
    
    
    
    
    // MARK: - 机型判断
    
    /// 模拟器
    static let simulator: Bool = {
        var simulator = false
        #if arch(i386) || arch(x86_64)
        simulator = true
        #endif
        return simulator
    }()
    
    /*
     * iPhone SE / iPhone 5s / iPhone 5 (4-inch) 320pt * 568pt @2x
     * iPhone 6, iPhone 6s, iPhone 7, iPhone 8, iPhone SE 2nd generation (4.7-inch) 375pt * 667pt @2x
     * iPhone 6 Plus, iPhone 6s Plus, iPhone 7 Plus, iPhone 8 Plus (5.5-inch) 414pt * 736pt @3x
     * iPhone X, iPhone Xs, iPhone 11 Pro, iPhone 12 mini 375pt * 812pt @3x
     * iPhone Xr, iPhone Xs Max, iPhone 11, iPhone 11 Pro Max 414pt * 896pt @2x || @3x
     * iPhone 12, iPhone 12 Pro 390pt * 844pt @3x
     * iPhone 12 Pro Max 428pt * 926pt @3x
     */
    
    /// iPhone
    struct iPhoneSeries {
        
        /// all
        static let all = UIDevice.current.userInterfaceIdiom == .phone
        
        /// 全面屏 - 带圆角
        static var roundedCorner: Bool {
            get {
                if iPhoneSeries.all {
                    if #available(iOS 11.0, *) {
                        return UIApplication.shared.windows.first!.safeAreaInsets.bottom > 0
                    }else{
                        return false
                    }
                }
                return false
            }
        }
        
        /// iPhone SE, iPhone 5s, iPhone 5, iPhone 4s 及其以下
        static let screenSizeIsLessThanOrEqual_iPhoneSE = (all && max(KScreenWidth, KScreenHeight) <= 568)
        /// iPhone 6, iPhone 6s, iPhone 7, iPhone 8
        static let screenSizeIsEqual_iPhone8 = (all && min(KScreenWidth, KScreenHeight) == 375 && max(KScreenWidth, KScreenHeight) == 667)
        /// iPhone 6 Plus, iPhone 6s Plus, iPhone 7 Plus, iPhone 8 Plus
        static let screenSizeIsEqual_iPhone8Plus = (all && min(KScreenWidth, KScreenHeight) == 414 && max(KScreenWidth, KScreenHeight) == 736)
        /// iPhone X, iPhone Xs, iPhone 11 Pro, iPhone 12 mini
        static let screenSizeIsEqual_iPhoneX = (all && min(KScreenWidth, KScreenHeight) == 375 && max(KScreenWidth, KScreenHeight) == 812)
        /// iPhone Xr, iPhone Xs Max, iPhone 11, iPhone 11 Pro Max
        static let screenSizeIsEqual_iPhoneXr = (all && min(KScreenWidth, KScreenHeight) == 414 && max(KScreenWidth, KScreenHeight) == 896)
        /// iPhone 12, iPhone 12 Pro
        static let screenSizeIsEqual_iPhone12 = (all && min(KScreenWidth, KScreenHeight) == 390 && max(KScreenWidth, KScreenHeight) == 844)
        /// iPhone 12 Pro Max
        static let screenSizeIsEqual_iPhone12ProMax = (all && min(KScreenWidth, KScreenHeight) == 428 && max(KScreenWidth, KScreenHeight) == 926)
        
    }
    
    /// iPad
    struct iPadSeries {
        
        /// all
        static let all = UIDevice.current.userInterfaceIdiom == .pad
        
        /// 全面屏 - 带圆角
        static var roundedCorner: Bool {
            get {
                if iPadSeries.all {
                    if #available(iOS 11.0, *) {
                        return UIApplication.shared.windows.first!.safeAreaInsets.bottom > 0
                    }else{
                        return false
                    }
                }
                return false
            }
        }
    }
    
    static func checkPushNotification(_ isEnable : @escaping ((Bool)->())){
        UNUserNotificationCenter.current().getNotificationSettings(completionHandler: { setttings in
            DispatchQueue.mainAsync {
                switch setttings.authorizationStatus{
                case .authorized:
                    isEnable(true)
                default:
                    isEnable(false)
                }
            }
        })
    }
    
    /// 全面屏
    static var roundedCorner: Bool {
        
        return iPhoneSeries.roundedCorner || iPadSeries.roundedCorner
        
    }
    
    // MARK: - 磁盘空间
    func MBFormatter(_ bytes: Int64) -> String {
        let formatter = ByteCountFormatter()
        formatter.allowedUnits = ByteCountFormatter.Units.useMB
        formatter.countStyle = ByteCountFormatter.CountStyle.decimal
        formatter.includesUnit = false
        return formatter.string(fromByteCount: bytes) as String
    }
    
    //MARK: Get String Value
    var totalDiskSpaceInGB:String {
       return ByteCountFormatter.string(fromByteCount: totalDiskSpaceInBytes, countStyle: ByteCountFormatter.CountStyle.decimal)
    }
    
    var freeDiskSpaceInGB:String {
        return ByteCountFormatter.string(fromByteCount: freeDiskSpaceInBytes, countStyle: ByteCountFormatter.CountStyle.decimal)
    }
    
    var usedDiskSpaceInGB:String {
        return ByteCountFormatter.string(fromByteCount: usedDiskSpaceInBytes, countStyle: ByteCountFormatter.CountStyle.decimal)
    }
    
    var totalDiskSpaceInMB:String {
        return MBFormatter(totalDiskSpaceInBytes)
    }
    
    var freeDiskSpaceInMB:String {
        return MBFormatter(freeDiskSpaceInBytes)
    }
    
    var usedDiskSpaceInMB:String {
        return MBFormatter(usedDiskSpaceInBytes)
    }
    
    //MARK: Get raw value
    var totalDiskSpaceInBytes:Int64 {
        guard let systemAttributes = try? FileManager.default.attributesOfFileSystem(forPath: NSHomeDirectory() as String),
            let space = (systemAttributes[FileAttributeKey.systemSize] as? NSNumber)?.int64Value else { return 0 }
        return space
    }
    
    /*
     Total available capacity in bytes for "Important" resources, including space expected to be cleared by purging non-essential and cached resources. "Important" means something that the user or application clearly expects to be present on the local system, but is ultimately replaceable. This would include items that the user has explicitly requested via the UI, and resources that an application requires in order to provide functionality.
     Examples: A video that the user has explicitly requested to watch but has not yet finished watching or an audio file that the user has requested to download.
     This value should not be used in determining if there is room for an irreplaceable resource. In the case of irreplaceable resources, always attempt to save the resource regardless of available capacity and handle failure as gracefully as possible.
     */
    var freeDiskSpaceInBytes:Int64 {
        if let space = try? URL(fileURLWithPath: NSHomeDirectory() as String).resourceValues(forKeys: [URLResourceKey.volumeAvailableCapacityForImportantUsageKey]).volumeAvailableCapacityForImportantUsage {
            return space
        } else {
            return 0
        }
    }
    
    var usedDiskSpaceInBytes:Int64 {
       return totalDiskSpaceInBytes - freeDiskSpaceInBytes
    }
    
}

