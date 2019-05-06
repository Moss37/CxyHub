//
//  UserAgent.swift
//  bili-universal
//
//  Created by caony on 2019/4/25.
//  Copyright © 2019年 CJ. All rights reserved.
//

import Foundation
import UIKit

class UserAgent {
    private static var defaults = UserDefaults(suiteName: AppInfo.sharedContainerIdentifier)!
    
    private static func clientUserAgent(prefix: String) -> String {
        return "\(prefix)/\(AppInfo.appVersion)b\(AppInfo.buildNumber) (\(DeviceInfo.deviceModel()); iPhone OS \(UIDevice.current.systemVersion)) (\(AppInfo.displayName))"
    }
    
    static var defaultClientUserAgent: String {
        return clientUserAgent(prefix: "bili-universal/8470")
    }
    
    static var defaultUserAgent: String {
        return "bili-universal/8470 CFNetwork/974.2.1 Darwin/18.0.0"
    }
    
}
