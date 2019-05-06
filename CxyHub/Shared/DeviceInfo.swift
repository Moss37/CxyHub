//
//  DeviceInfo.swift
//  bili-universal
//
//  Created by caony on 2019/4/25.
//  Copyright © 2019年 CJ. All rights reserved.
//

import Foundation
import UIKit

class DeviceInfo {
    // List of device names that don't support advanced visual settings
    static let lowGraphicsQualityModels = ["iPad", "iPad1,1", "iPhone1,1", "iPhone1,2", "iPhone2,1", "iPhone3,1", "iPhone3,2", "iPhone3,3", "iPod1,1", "iPod2,1", "iPod2,2", "iPod3,1", "iPod4,1", "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4", "iPad3,1", "iPad3,2", "iPad3,3"]
    
    static var specificModelName: String {
        var systemInfo = utsname()
        uname(&systemInfo)
        
        let machine = systemInfo.machine
        let mirror = Mirror(reflecting: machine)
        var identifier = ""
        
        // Parses the string for the model name via NSUTF8StringEncoding, refer to
        // http://stackoverflow.com/questions/26028918/ios-how-to-determine-iphone-model-in-swift
        for child in mirror.children.enumerated() {
            if let value = child.1.value as? Int8, value != 0 {
                identifier.append(String(UnicodeScalar(UInt8(value))))
            }
        }
        return identifier
    }
    
    class func deviceModel() -> String {
        return UIDevice.current.model
    }
    
    class func isSimulator() -> Bool {
        return ProcessInfo.processInfo.environment["SIMULATOR_ROOT"] != nil
    }
    
    class func hasConnectivity() -> Bool {
        let status = Reach().connectionStatus()
        switch status {
        case .online(.wwan), .online(.wiFi):
            return true
        default:
            return false
        }
    }
}
