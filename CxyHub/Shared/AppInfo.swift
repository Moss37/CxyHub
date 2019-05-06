//
//  AppInfo.swift
//  bili-universal
//
//  Created by caony on 2019/4/25.
//  Copyright © 2019年 CJ. All rights reserved.
//

import UIKit

class AppInfo {
    static var applicationBundle: Bundle {
        let bundle = Bundle.main
        return bundle
    }
    
    static var displayName: String {
        return applicationBundle.object(forInfoDictionaryKey: "CFBundleDisplayName") as! String
    }
    
    static var appVersion: String {
        return applicationBundle.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String
    }
    
    static var buildNumber: String {
        return applicationBundle.object(forInfoDictionaryKey: String(kCFBundleVersionKey)) as! String
    }
    
    static var majorAppVersion: String {
        return appVersion.components(separatedBy: ".").first!
    }
    
    static var sharedContainerIdentifier: String {
        let bundleIdentifier = baseBundleIdentifier
        return "group." + bundleIdentifier
    }
    
    /// Return the keychain access group.
    static func keychainAccessGroupWithPrefix(_ prefix: String) -> String {
        let bundleIdentifier = baseBundleIdentifier
        return prefix + "." + bundleIdentifier
    }
    
    static var baseBundleIdentifier: String {
        let bundle = Bundle.main
        let packageType = bundle.object(forInfoDictionaryKey: "CFBundlePackageType") as! String
        let baseBundleIdentifier = bundle.bundleIdentifier!
        if packageType == "XPC!" {
            let components = baseBundleIdentifier.components(separatedBy: ".")
            return components[0..<components.count-1].joined(separator: ".")
        }
        return baseBundleIdentifier
    }
}
