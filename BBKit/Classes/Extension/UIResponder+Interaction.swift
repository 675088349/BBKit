//
//  UIResponder+Interaction.swift
//  BBKit
//
//  Created by lk on 2023/2/17.
//

import UIKit

public protocol XHNCallbackProtocol: NSObject {
    func operationCallback(sendEvent: EventProtocol, object: Any?)
}

extension UIResponder {

    // Callback view 向上发消息 遵守PGCallbackProtocol
    public func performOperation(sendEvent:EventProtocol) {
        if let view = self as? UIView {
            var next = view.next
            while next != nil {
                let call = next as? XHNCallbackProtocol
                call?.operationCallback(sendEvent: sendEvent, object: self)
                next = next?.next
            }

           return
        }

        if let vc = self as? UIViewController {
            let supvc = vc.parent
            if let call = supvc as? XHNCallbackProtocol {
                call.operationCallback(sendEvent: sendEvent, object: self)
            }
        }
    }
}
