//
//  AppConstants.swift
//  CxyHub
//
//  Created by caony on 2019/4/25.
//  Copyright © 2019年 CJ. All rights reserved.
//

import Foundation
import UIKit

public enum AppBuildChannel: String {
    
    case release   = "release"
    case beta      = "beta"
    case developer = "developer"
}

public struct AppConstants {
    public static let scheme: String = {
        guard let identifier = Bundle.main.bundleIdentifier else {
            return "unknown"
        }
        let scheme = identifier.replacingOccurrences(of: "CJ.", with: "")
        if scheme == "" {
            return scheme
        }
        return scheme
    }()
    
    public static let clientId: String = "b3a4f6ff2baac32c1a10"
    public static let clientSecret: String = "33ae7ba4b5c89bc679e255ddae27890030c80574"
    public static let callbackUrl: String = "cxyhub://"
    
    public static let loginSuccessNotificationName: String = "loginSuccessNotificationName"
}

