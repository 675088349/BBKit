//
//  UIButton+TimeBtn.swift
//  BBKit
//
//  Created by 肥啊 on 2023/3/1.
//

import UIKit

public extension UIButton {
    func start(_ time: Int = 3, timeText: String = "跳过", title: String = "", disabled: Bool = false, finish: (()->())? = nil) {
        var timeOut = time
        let queue:DispatchQueue = DispatchQueue.global(qos: DispatchQoS.QoSClass.default)
        let timer = DispatchSource.makeTimerSource(flags: [], queue: queue)
        timer.schedule(deadline: .now(), repeating: .seconds(1))
        timer.setEventHandler {[weak self] in
            guard let self = self else {
                timer.cancel()
                return
            }
            if timeOut <= 0 {
                timer.cancel();
                DispatchQueue.main.async {
                    self.setTitle(title, for: .normal)
                    if disabled {
                        self.isUserInteractionEnabled = true
                        self.isEnabled = true
                    }
                    finish?()
                }
            } else {
                DispatchQueue.main.async {
                    self.setTitle("\(timeOut)\(timeText)", for: .normal)
                    if disabled {
                        self.isUserInteractionEnabled = false
                        self.isEnabled = false
                    }
                }
                timeOut -= 1;
            }

        }
        timer.resume()
    }
}
