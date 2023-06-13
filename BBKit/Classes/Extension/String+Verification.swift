//
//  String+Verification.swift
//  BBKit
//
//  Created by lk on 2023/3/1.
//

import Foundation

extension String {
    
    /// 验证邮箱
    public func validateEmail() -> Bool {
        if self.count == 0 {
            return false
        }
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let emailTest:NSPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailTest.evaluate(with: self)
    }
    
    /// 验证手机号
    public func isPhoneNumber() -> Bool {
        if self.count == 11 {
            return true
        }
        return false
    }
    
    //密码正则  6-8位字母和数字组合
    public func isPasswordRuler() -> Bool {
        let passwordRule = "^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{6,8}$"
        let regexPassword = NSPredicate(format: "SELF MATCHES %@",passwordRule)
        if regexPassword.evaluate(with: self) == true {
            return true
        }else
        {
            return false
        }
    }
}
