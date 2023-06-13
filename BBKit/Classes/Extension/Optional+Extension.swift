//
//  Optional+Extension.swift
//  BBKit
//
//  Created by 肥啊 on 2023/2/18.
//

import Foundation
import UIKit

public extension Optional where Wrapped == Bool {
    var unwraps: Bool {
        return self ?? false
    }
}

public extension Optional where Wrapped == Int {
    var unwraps: Int {
        return self ?? 0
    }
}

public extension Optional where Wrapped == CGFloat {
    var unwraps: CGFloat {
        return self ?? 0
    }
}

public extension Optional where Wrapped == Double {
    var unwraps: Double {
        return self ?? 0
    }
}

public extension Optional where Wrapped == Float {
    var unwraps: Float {
        return self ?? 0
    }
}

public extension Optional where Wrapped == NSString {
    var unwraps: NSString {
        return self ?? ""
    }
}

public extension Optional where Wrapped == String {
    var unwraps: String {
        return self ?? ""
    }
}

