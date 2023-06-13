//
//  BBDevice.swift
//  Alamofire
//
//  Created by lk on 2023/3/1.
//

import UIKit
import Photos
import CoreLocation

public func BBInfoPlist(_ key: String) -> String {
    let info = Bundle.main.infoDictionary
    return info?[key] as? String ?? ""
}

public class BBDevice {
    
    // app名称
    public static func appName() -> String {
        return BBInfoPlist("CFBundleDisplayName")
    }
    
    // app 版本
    public static func appVersion() -> String {
        return BBInfoPlist("CFBundleShortVersionString")
    }
    // app build版本
    public static func appBuild() -> String {
        return BBInfoPlist("CFBundleVersion")
    }
    
    // 设备版本
    public static func deciveVersion() -> String {
        return UIDevice.current.systemName
    }
    

    public static func saveImageToPhotoLibrary(image: UIImage, saveCompletionHandler: @escaping (Bool) -> Void) {
        // 判断权限
        switch PHPhotoLibrary.authorizationStatus() {
            case .authorized:
            BBDevice.saveImage(image: image) { success in
                saveCompletionHandler(success)
            }
            case .notDetermined:
                PHPhotoLibrary.requestAuthorization { status in
                    if status == .authorized {
                        BBDevice.saveImage(image: image) { success in
                            saveCompletionHandler(success)
                        }
                    } else {
                        saveCompletionHandler(false)
                    }
                }
            case .restricted, .denied:
                if let url = URL.init(string: UIApplication.openSettingsURLString) {
                    if UIApplication.shared.canOpenURL(url) {
                        UIApplication.shared.canOpenURL(url)
                    }
                    saveCompletionHandler(false)
                }
        default:
            saveCompletionHandler(false)
        }
    }
    
    public static func saveImage(image: UIImage, saveCompletionHandler: @escaping (Bool) -> Void) {
        PHPhotoLibrary.shared().performChanges {//performChangesAndAwiat
            PHAssetChangeRequest.creationRequestForAsset(from: image)
        } completionHandler: { (success, error) in
            if success {
                saveCompletionHandler(true)
            } else {
                saveCompletionHandler(false)
            }
        }
    }
    
    @discardableResult
    public static func checkIsCanUseLocationServices(showAlert: Bool = false) -> Bool {
        var isPermission = false
        
        let state = CLLocationManager.authorizationStatus()
        
        switch state {
        case .restricted, .denied:
            if CLLocationManager.locationServicesEnabled() {
                print("定位开启 但被拒")
            } else {
                print("定位关闭 不可用")
            }
        default:
            isPermission = true
        }
        
        if !isPermission, showAlert {
            UIAlertController.showAlert(message: "请您设置允许APP使用定位服务\n设置>隐私>位置", actionAry: ["去打开"]) { index, action in
                if let url = URL.init(string: UIApplication.openSettingsURLString) {
                    if UIApplication.shared.canOpenURL(url) {
                        UIApplication.shared.canOpenURL(url)
                    }
                }
            }
        }
        
        return isPermission
    }
}
